//
//  TextInputViewController.m
//  DataCollection
//
//  Created by ChuanKai on 15/3/17.
//  Copyright (c) 2015年 ChuanKai. All rights reserved.
//

#import "TextInputViewController.h"
#import "XLForm.h"
#import "FloatLabeledTextFieldCell.h"
#import "KVNProgress.h"

@interface TextInputViewController ()
@property (nonatomic, strong) NSMutableDictionary *cropNameDict;
@property (nonatomic, strong) NSString *tableId;
@end

NSString *const kName = @"tckssg";
NSString *const kEmail = @"email";
@implementation TextInputViewController

-(id)initWithCrops:(NSDictionary *)crops cropsData:(DataModel *)cropsData menuGroup:(MenuGroup *)memuGroup{
    
    self.tableId = cropsData.internalBaseClassIdentifier;
    XLFormDescriptor * formDescriptor = [XLFormDescriptor formDescriptorWithTitle:@"Text Fields"];
    XLFormRowDescriptor * row;
    XLFormSectionDescriptor * section;
    
    for (NSString *key in memuGroup.childMenu.allKeys) {
        NSDictionary *nameDict = [memuGroup.childMenu valueForKey:key];
        for (NSString *nameStr in nameDict.allKeys) {
            self.cropNameDict[[nameDict valueForKey:nameStr]] = nameStr;
        }
    }
    
    formDescriptor.assignFirstResponderOnShow = NO;
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"TextField Types"];
//    section.footerTitle = @"This is a long text that will appear on section footer";
    [formDescriptor addFormSection:section];
    
    NSArray *cropsArray = cropsData.cropDetail;
    NSMutableDictionary *tempCropDict = [NSMutableDictionary dictionary];
    for (CropDetail *cropDetail in cropsArray) {
        tempCropDict[[NSString stringWithFormat:@"%ld",cropDetail.code]] = cropDetail.acreage;
    }
    
    for (NSString *key in crops.allKeys) {
        row = [XLFormRowDescriptor formRowDescriptorWithTag: [crops valueForKey:key] rowType:XLFormRowDescriptorTypeFloatLabeledTextField title:key];
        row.value = [tempCropDict valueForKey:[crops valueForKey:key]];
        [section addFormRow:row];
    }
//    self.view.frame = CGRectMake(300, 0, ScreenWidth - 600, ScreenHeight - 64);
    return [super initWithForm:formDescriptor];
}

-(id)initWithAllCrops:(MenuGroup *)crops cropsData:(DataModel *)cropsData{
     self.tableId = cropsData.internalBaseClassIdentifier;
    
    XLFormDescriptor * formDescriptor = [XLFormDescriptor formDescriptorWithTitle:@"Text Fields"];
    XLFormRowDescriptor * row;
    XLFormSectionDescriptor * section;
    
    for (NSString *key in crops.childMenu.allKeys) {
        NSDictionary *nameDict = [crops.childMenu valueForKey:key];
        for (NSString *nameStr in nameDict.allKeys) {
            self.cropNameDict[[nameDict valueForKey:nameStr]] = nameStr;
        }
    }
    
    
    NSArray *cropsArray = cropsData.cropDetail;
    NSMutableDictionary *tempCropDict = [NSMutableDictionary dictionary];
    for (CropDetail *cropDetail in cropsArray) {
        tempCropDict[[NSString stringWithFormat:@"%ld",cropDetail.code]] = cropDetail.acreage;
    }
    
    NSDictionary *childMenu = crops.childMenu;
    for (NSString *key in crops.childMenu.allKeys) {
        NSDictionary *tempDict = [childMenu valueForKey:key];
        section = [XLFormSectionDescriptor formSectionWithTitle:key];
         [formDescriptor addFormSection:section];
        for (NSString *keystr in tempDict.allKeys) {
            row = [XLFormRowDescriptor formRowDescriptorWithTag:[tempDict valueForKey:keystr] rowType:XLFormRowDescriptorTypeFloatLabeledTextField title:keystr];
            row.value = [tempCropDict valueForKey:[tempDict valueForKey:keystr]];
            [section addFormRow:row];
        }
        
    }
     return [super initWithForm:formDescriptor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setTintColor:[UIColor redColor]];
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    [self addHeadView];
}

-(void)addHeadView{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/3, 64)];
    headView.backgroundColor = kColor(64, 64, 87);
    
    UIButton *saveButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/3-100, 20, 100, 44)];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(savePressed:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:saveButton];
    [self.view addSubview:headView];
}

-(void)savePressed:(UIBarButtonItem * __unused)button{
    
    NSArray * validationErrors = [self formValidationErrors];
    if (validationErrors.count > 0){
        [self showFormValidationError:[validationErrors firstObject]];
        return;
    }
    
    NSMutableArray *jsonArray = [NSMutableArray array];
    
    
    NSDictionary *valueDict = [self formValues];
    for (NSString *key in valueDict.allKeys) {
        NSMutableDictionary *tempDict = [NSMutableDictionary dictionary];
        tempDict[@"belong_table"] = self.tableId;
        NSString *acreage = [valueDict valueForKey:key];
        if ([acreage isEqual:[NSNull null]] || [acreage isEqualToString:@""]) {
            acreage = @"null";
        }
        tempDict[@"acreage"] = acreage;
        tempDict[@"cultivar_name"] = [self.cropNameDict valueForKey:key];
        tempDict[@"code"] = key;
        [jsonArray addObject:tempDict];
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:jsonArray options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [CKCKProgress showNetworkLoadingWithStatus:@"正在上传，请稍等" onView:nil];
    params[@"data"] = jsonString;
    [HTTPTool postWithSourceString:@"SaveCrop.ashx" params:params success:^(id JSON) {
        [CKCKProgress dismissWithCompletion:^{
            [CKCKProgress showSuccessWithStatsu:@"数据保存成功" onView:nil completion:nil];
        }];
    } failure:^(NSError *error) {
        [CKCKProgress dismissWithCompletion:^{
            [CKCKProgress showErrorWithStatsu:@"数据保存失败" onView:nil completion:nil];
        }];
    }];
}


- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

#pragma  getter and setter

-(NSMutableDictionary *)cropNameDict{
    if (!_cropNameDict) {
        _cropNameDict = [NSMutableDictionary dictionary];
    }
    return _cropNameDict;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
