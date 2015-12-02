//
//  ViewController.m
//  UIImagePickerDemo
//
//  Created by Moode-TDD06 on 15/12/2.
//  Copyright © 2015年 liuwei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takePicture:(id)sender
{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        NSArray *temp_MediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
        picker.mediaTypes = temp_MediaTypes;
        picker.delegate = self;
        picker.allowsImageEditing = YES;
    }
    
    [self presentModalViewController:picker animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    if ([mediaType isEqualToString:@"public.image"]){
        
        UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        ;    NSLog(@"found an image");
        
        NSString *imageFile = [documentsDirectory stringByAppendingPathComponent:@"temp.jpg"];
        ;    NSLog(@"%@", imageFile);
        
        success = [fileManager fileExistsAtPath:imageFile];
        if(success) {
            success = [fileManager removeItemAtPath:imageFile error:&error];
        }
        
        _imageView.image = image;
        [UIImageJPEGRepresentation(image, 1.0f) writeToFile:imageFile atomically:YES];
        
        //SETIMAGE(image);
        //CFShow([[NSFileManager defaultManager] directoryContentsAtPath:[NSHomeDirectory() stringByAppendingString:@"/Documents"]]);
        ;    }
    else if([mediaType isEqualToString:@"public.movie"]){
        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
        NSLog(@"%@", videoURL);
        NSLog(@"found a video");
        NSData *videoData = [NSData dataWithContentsOfURL:videoURL];
        
        /****************************************/
        
        NSString *videoFile = [documentsDirectory stringByAppendingPathComponent:@"temp.mov"];
        NSLog(@"%@", videoFile);
        
        success = [fileManager fileExistsAtPath:videoFile];
        if(success) {
            success = [fileManager removeItemAtPath:videoFile error:&error];
        }
        [videoData writeToFile:videoFile atomically:YES];
        //CFShow([[NSFileManager defaultManager] directoryContentsAtPath:[NSHomeDirectory() stringByAppendingString:@"/Documents"]]);
        ;    //NSLog(videoURL);
    }
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissModalViewControllerAnimated:YES];

}

@end
