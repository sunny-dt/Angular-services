import { Component, OnInit, AfterViewInit, ViewChild, ElementRef } from '@angular/core';
import {MatPaginator, MatSort, MatDialog, MatDialogConfig} from "@angular/material";
import { PlatformLatestService } from 'src/app/shared/platform-latest.service';
import { PlatformLatestsDataSource } from 'src/app/shared/platform-latest.datasource';
import { fromEvent, merge } from 'rxjs';
import { debounceTime, distinctUntilChanged, tap } from 'rxjs/operators';
import { PlatformLatestFormComponent } from '../platform-latest-form/platform-latest-form.component';
import { NotificationService } from 'src/app/shared/notification.service';
import { DialogService } from 'src/app/shared/dialog.service';
import { ActivatedRoute, Router, Route } from '@angular/router';
import { AuthorizationService } from 'src/app/shared/authServices/authorization.service';

@Component({
  selector: 'app-platform-latest-list',
  templateUrl: './platform-latest-list.component.html',
  styleUrls: ['./platform-latest-list.component.css']
})
export class PlatformLatestListComponent implements OnInit, AfterViewInit {

  
  dataSource: PlatformLatestsDataSource;

  displayedColumns= ["id", "linked_element_type", "linked_element_id", "type_title", "title", "sub_title", "created_by_id", "created_by_name", "modified_by_id", "modified_by_name","c_date", "m_date", "serial_order", "actions"];

  @ViewChild(MatPaginator) paginator: MatPaginator;

  @ViewChild(MatSort) sort: MatSort;

  @ViewChild('input') input: ElementRef;

  searchText : string;

  constructor(public latestService : PlatformLatestService, private dialog : MatDialog,
    private notificationService : NotificationService,
    private dialogService : DialogService,
    private authorizationService : AuthorizationService,
    private route : ActivatedRoute,
    private router : Router) { }

  ngOnInit() {

    this.dataSource = new PlatformLatestsDataSource(this.latestService, this.dialogService, this.authorizationService);

    this.dataSource.loadPlatformLatests('','asc','id', 1, this.latestService.defaultPageSize);
  }

  ngAfterViewInit()
  {
    
    this.sort.sortChange.subscribe(() => this.paginator.pageIndex = 0);

    fromEvent(this.input.nativeElement,'keyup')
        .pipe(
            debounceTime(150),
            distinctUntilChanged(),
            tap(() => {
                this.paginator.pageIndex = 0;

                this.loadPlatformLatestsPage();
            })
        )
        .subscribe();

        fromEvent(this.input.nativeElement,'change')
        .pipe(
            debounceTime(150),
            distinctUntilChanged(),
            tap(() => {
                this.paginator.pageIndex = 0;

                this.loadPlatformLatestsPage();
            })
        )
        .subscribe();

    

    merge(this.sort.sortChange, this.paginator.page)
    .pipe(
        tap(() => this.loadPlatformLatestsPage())
    )
    .subscribe();
  }

  loadPlatformLatestsPage() {
    this.dataSource.loadPlatformLatests(
        this.input.nativeElement.value,
        this.sort.active,
        this.sort.direction,
        this.paginator.pageIndex + 1,
        this.paginator.pageSize);
  }

  onSearchClear()
  {
    this.searchText = "";
  }

  onCreate()
  {
    const dialogConfig = new MatDialogConfig;
    dialogConfig.disableClose = true;
    dialogConfig.autoFocus = true;
    dialogConfig.width = "60%";
    this.dialog.open(PlatformLatestFormComponent, dialogConfig).afterClosed().subscribe(data => {
      console.log(data);
      if(data)
      {
        this.loadPlatformLatestsPage();
      }
    });
  }

  onEdit(row)
  {
    this.latestService.populateForm(row);

    const dialogConfig = new MatDialogConfig;
    dialogConfig.disableClose = true;
    dialogConfig.autoFocus = true;
    dialogConfig.width = "60%";
    this.dialog.open(PlatformLatestFormComponent, dialogConfig).afterClosed().subscribe(data => {
      console.log(data);
      if(data)
      {
        this.loadPlatformLatestsPage();
      }
    });
  }

  onDelete(latest)
  {


    this.dialogService.openConfirmDialog('Confirm Delete ?').afterClosed().subscribe(res => {
      if(res)
      {
        this.latestService.deletePlatformLatest(latest).subscribe(response => {

          console.log("Response - deletePlatformLatest : ", response);
          this.notificationService.success("Deleted successfully");
          this.loadPlatformLatestsPage();
          
        }, error => {
    
          this.notificationService.failure(error.error);
        });
      }
    });
  }

  // printpath(parent: String, config: Route[]) {
  //   for (let i = 0; i < config.length; i++) {
  //     let route = config[i];
  //     console.log(parent + '/' + route.path);
  //     if (route.children) {
  //       const currentPath = route.path ? parent + '/' + route.path : parent;
  //       this.printpath(currentPath, route.children);
  //     }
  //   }
  // }

 

}
