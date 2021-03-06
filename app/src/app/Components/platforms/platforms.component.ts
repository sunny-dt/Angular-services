import { AuthorizationService } from './../../authorization.service';

import { Component, OnInit, ElementRef, ViewChild, ViewEncapsulation, Inject } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { ApiService } from './../../Services/api.service';
import { MatDialogRef, MatDialog, MAT_DIALOG_DATA } from '@angular/material';
import { TokenResponse } from '@openid/appauth';
import { Location } from '@angular/common';
import { AppComponent } from '../.././app.component';
import { StorageService } from 'src/app/Storage.service';

@Component({

  selector: 'app-platforms',
  templateUrl: './platforms.component.html',
  styleUrls: ['./platforms.component.css'],
  encapsulation: ViewEncapsulation.None
})

export class PlatFormsComponent implements OnInit {

  public platformsList: any[];
  selectedPosition;
  public form: FormGroup;
  isShowToolTip:boolean = true;

  toolTipIcon: string = "assets/Icon-Info-Inactive@1x.png";

  @ViewChild('opIdInput') opIdInput: ElementRef<HTMLInputElement>;

  constructor(private apiService: ApiService, private router: Router, private route: ActivatedRoute, 
    private formBuilder: FormBuilder, public dialog: MatDialog,public authorizationService:AuthorizationService,
    public location: Location, private appComp: AppComponent, private storageService: StorageService) {}

  ngOnInit() {

    this.apiService.showheader();
    this.appComp.toggleRightSidenav();

    localStorage.setItem("ExitButtonVisibility", 'false');
    
    let showGlobalHeader = localStorage.getItem('ShowGlobalHeader');
    console.log("ngOnInit ShowGlobalHeader ", showGlobalHeader);
    
    if (showGlobalHeader == "true") {

      this.appComp.search();
      localStorage.setItem("ShowGlobalHeader", "false");
    } else {

      this.appComp.searchback();
    }

    
    let localStorageItems = ["SelectedOPID", "SelectedPlatform", "SelectedChambersList"]
    this.storageService.removeLocalStorageByItems(localStorageItems);

    this.form = this.formBuilder.group({
      platform: [null, [Validators.required]],
    });

    this.getPlatforms();
    this.opIdInput.nativeElement.focus();
  }

  getPlatforms() {

    this.apiService.getPlatforms().subscribe(response => {

      console.log("Response - getPlatforms: ", response);
      this.platformsList = JSON.parse(JSON.stringify(response));
      console.log("Response - getPlatforms: json: ", this.platformsList);
    }, error => {
      
      console.log("error response", error);
      console.log("error status: ", error.status);
      console.log("error message: ", error.message);
      
      var errorCode = error.status;
      var errorMessage: string = '';
      
      if(errorCode == '0') {

        errorMessage = 'The server encountered an error. Please try again later';
      } else if(errorCode == '401') {
  
        errorMessage = 'You’re not authorized to access the resource that you requested. Please login with ok button';
      } else if(errorCode == '403') {

        errorMessage = 'Sorry, You don’t have permission to access this application';
      } else if(errorCode == '404') {

        errorMessage = 'The resource you’re looking for was not found';
      } else if(errorCode == '500') {

        errorMessage = 'The server encountered an error. Please try again later';
      } else {

        errorMessage = 'Something went wrong and we couldn\'t process your request';
      }

      console.log("error status after if: ", error.status);
      console.log("error message after if: ", error.message);

      const dialogRef = this.dialog.open(PlatformHttpErrorDialog, {

        panelClass: 'platformHttpErrorDialogBorderRadius',
        width: '460px',
        // height: 'auto',
        data: {errorMessage: errorMessage, errorCode: errorCode}
      });
    
      dialogRef.afterClosed().subscribe(result => {
    
        var fetchPlatform = localStorage.getItem('PlatformHttpDialogFrom');
        
        if (fetchPlatform === 'true') {

        this.authorizationService.authorize();
        } else {
      
        }
      });
    });
  }

  fetchPlatforms() {

    if(this.platformsList.length > 0) {

    }else{

      this.getPlatforms();
    }
  }

  onPlatFormListChange(event, index) {}

  focusFunction() {

    this.isShowToolTip = true;
    this.toolTipIcon = "assets/Icon-Info-Inactive@1x.png";
  }

  focusOutFunction() {

    if(this.opIdInput.nativeElement.value == '' ){

      this.isShowToolTip = false;
      this.toolTipIcon = "assets/info_icon@1x.png";
    } else {

      this.isShowToolTip = true;
      this.toolTipIcon = "assets/Icon-Info-Inactive@1x.png";
    }
  }

  backButton() {

   
    let localStorageItems = ["SelectedOPID", "SelectedPlatform", "SelectedChambersList"]
    this.storageService.removeLocalStorageByItems(localStorageItems);

    // this.location.back();
    this.router.navigate(['/launch']);
  }
  
  next() {

    
    let localStorageItems = ["SelectedChambersList"]
    this.storageService.removeLocalStorageByItems(localStorageItems);

    localStorage.setItem("SelectedPlatform", JSON.stringify(this.platformsList[this.selectedPosition]));
    localStorage.setItem("SelectedOPID", this.opIdInput.nativeElement.value);
    this.router.navigate(['platform/chambers'], { relativeTo: this.route });
  }
}

@Component({

  selector: 'platform-Http-Error-dialog',
  templateUrl: 'patformHttpErrorDialog.html',
})

export class PlatformHttpErrorDialog {

  errorCode: any; 
  constructor(public dialogRef: MatDialogRef<PlatformHttpErrorDialog>, @Inject(MAT_DIALOG_DATA) public data: DialogData) {

    this.errorCode = data.errorCode;
  }

  dialogOK() {
  
    if (this.errorCode == '401') {

      localStorage.setItem('PlatformHttpDialogFrom', 'true');
    } else{

      localStorage.setItem('PlatformHttpDialogFrom', 'false');
    }
    
    this.dialogRef.close();
  }
}

export interface DialogData {
  errorMessage: string;
  errorCode: any;
}