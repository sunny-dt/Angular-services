import { Component, OnInit } from '@angular/core';
import { PlatformRecommendedService } from 'src/app/shared/platform-recommended.service';
import { NotificationService } from 'src/app/shared/notification.service';
import { MatDialogRef, MatIconRegistry } from '@angular/material';
import {DomSanitizer} from '@angular/platform-browser';
import { UploadService } from 'src/app/shared/upload.service';
import { HttpEventType } from '@angular/common/http';
import { timeout } from 'rxjs/operators';


@Component({
  selector: 'app-platform-recommended-form',
  templateUrl: './platform-recommended-form.component.html',
  styleUrls: ['./platform-recommended-form.component.css']
})
export class PlatformRecommendedFormComponent implements OnInit {


  imageURL: string = "";
  showPlatformRecommendedImage: boolean = false;
  uploadingFile : boolean = false;
  uploadedPercntValue : number = 0;

  linkableElementTypes = [{name : 'product'}, {name : 'chamber'}];
  linkableElements  = {products : [{id : 1, name : 'Cubs PVD'}, {id : 2, name : 'Cubs CVD'}],
                            chambers : [{id : 1, name : 'Access2 Cu'}, {id : 2, name : 'Cu Ni Chamber'}]};

  currentLinkableElements : any[] = [];

  selectedLinkableElementType : any = null;
  selectedLinkableElement : any = null;


  disableLinkableElementSelection = true;


  constructor(public service : PlatformRecommendedService, 
    private uploadService : UploadService,
    private notificationService : NotificationService,
    private iconRegistry: MatIconRegistry,
    private sanitizer: DomSanitizer,
    public dialogRef : MatDialogRef<PlatformRecommendedFormComponent>) { }
    public saveAndAddNewTapped = false;
  
  
  ngOnInit() {

     this.loadPlatformRecommendedImage();
  }

  loadPlatformRecommendedImage()
  {
    this.showPlatformRecommendedImage = false;

    setTimeout(()=>{  
      
      this.imageURL = this.service.form.get('image_link').value;
        console.log(" imageURL: ", this.imageURL);
        if(this.imageURL)
        {
          //this.iconRegistry.addSvgIcon('modelSvgIcon', this.sanitizer.bypassSecurityTrustResourceUrl(this.imageURL));
          this.showPlatformRecommendedImage = true;
        }
        else
        {
          this.showPlatformRecommendedImage = false;
        } 

    }, 0);

    
  }

  loadLinkableElementsFor(type : string)
  {
      const elements = this.linkableElements[type]
      this.currentLinkableElements = elements;
  }

  onLinkableElementTypesSelectionChange(value)
  {

    console.log("selected value mat-select1",value);
    if(value != null)
    {
      this.disableLinkableElementSelection = false;
       if(value == 'product')
        this.loadLinkableElementsFor('products');
       else
        this.loadLinkableElementsFor('chambers');
    }
  }

  onLinkableElementSelectionChange(value)
  {
    console.log("selectedPostion 2nd mat selected id",value);
  }

  onFileChanged(event) {
    const selectedFile = event.target.files[0];
    console.log("selected file : ", selectedFile);

    this.uploadingFile = true;
    this.uploadService.uploadRecommendedFile(selectedFile)
    .subscribe(event => {
      console.log(event); 
      if(event.type == HttpEventType.UploadProgress)
      {
          this.uploadedPercntValue =  (event.loaded / event.total) * 100;
      }
      else if(event.type == HttpEventType.Response)
      {

          const url = event.body["url"];
          const filename = event.body["filename"];
          console.log(`url = ${url}   filename = ${filename}`);
          this.service.form.get('image_link').setValue(url);
          this.imageURL = this.service.form.get('image_link').value;
          this.service.form.get('image_filename').setValue(filename);
          
          this.uploadingFile = false;
          this.uploadedPercntValue = 0;

          this.loadPlatformRecommendedImage();
          console.log('service.form ->', this.service.form);
      }
      else if(event.type == HttpEventType.ResponseHeader)
      {
          this.uploadingFile = false;
          this.uploadedPercntValue = 0;
          console.log("headers : ", event.headers);
          if(event.status == 409)
          {
            this.notificationService.failure("model file needs to be a PNG");
          }
          
      }
      
    });
  }

  onClear()
  {
    this.service.form.reset();
  }

  onCancel()
  {
    if(this.saveAndAddNewTapped)
      this.onClose('created');
    else
      this.onClose(null);
  }

  onSubmit()
  {
    if(this.service.form.valid)
    {
        if(this.service.form.get('id').value)
        {
          this.service.updatePlatformRecommended(this.service.form.value).subscribe(response => {

            console.log("Response - update platform-recommended-form : ", response);
            this.notificationService.success("Updated successfully");
            this.onClose('edited');
            
          }, error => {
    
            this.notificationService.failure(error.error);
          });
        }
        else
        {
          this.service.insertPlatformRecommended(this.service.form.value).subscribe(response => {

            console.log("Response - add new platform-recommended-form : ", response);
            this.notificationService.success("Saved successfully");
            this.onClose('created');
            
          }, error => {
    
            this.notificationService.failure(error.error);
          });
        }

     
    }
  }

  onSubmitnAddNew()
  {
    if(this.service.form.valid)
    {
      this.service.insertPlatformRecommended(this.service.form.value).subscribe(response => {
        this.saveAndAddNewTapped = true;
        console.log("Response - add new platform-recommended-form : ", response);
        this.notificationService.success("Saved successfully");
        this.imageURL = null;
        this.service.form.reset();
        
      }, error => {

        this.notificationService.failure(error.error);
      });
    }
  }

  onClose(data)
  {
    this.service.form.reset();
    this.service.initializeFormGroup();
    this.dialogRef.close(data);
  }

  

}
