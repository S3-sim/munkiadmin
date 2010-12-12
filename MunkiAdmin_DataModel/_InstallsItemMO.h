// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to InstallsItemMO.h instead.

#import <CoreData/CoreData.h>


@class PackageMO;








@interface InstallsItemMOID : NSManagedObjectID {}
@end

@interface _InstallsItemMO : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (InstallsItemMOID*)objectID;



@property (nonatomic, retain) NSString *munki_CFBundleShortVersionString;

//- (BOOL)validateMunki_CFBundleShortVersionString:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *munki_path;

//- (BOOL)validateMunki_path:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *munki_CFBundleIdentifier;

//- (BOOL)validateMunki_CFBundleIdentifier:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *munki_md5checksum;

//- (BOOL)validateMunki_md5checksum:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *munki_CFBundleName;

//- (BOOL)validateMunki_CFBundleName:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *munki_type;

//- (BOOL)validateMunki_type:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet* packages;
- (NSMutableSet*)packagesSet;




@end

@interface _InstallsItemMO (CoreDataGeneratedAccessors)

- (void)addPackages:(NSSet*)value_;
- (void)removePackages:(NSSet*)value_;
- (void)addPackagesObject:(PackageMO*)value_;
- (void)removePackagesObject:(PackageMO*)value_;

@end

@interface _InstallsItemMO (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveMunki_CFBundleShortVersionString;
- (void)setPrimitiveMunki_CFBundleShortVersionString:(NSString*)value;


- (NSString*)primitiveMunki_path;
- (void)setPrimitiveMunki_path:(NSString*)value;


- (NSString*)primitiveMunki_CFBundleIdentifier;
- (void)setPrimitiveMunki_CFBundleIdentifier:(NSString*)value;


- (NSString*)primitiveMunki_md5checksum;
- (void)setPrimitiveMunki_md5checksum:(NSString*)value;


- (NSString*)primitiveMunki_CFBundleName;
- (void)setPrimitiveMunki_CFBundleName:(NSString*)value;


- (NSString*)primitiveMunki_type;
- (void)setPrimitiveMunki_type:(NSString*)value;




- (NSMutableSet*)primitivePackages;
- (void)setPrimitivePackages:(NSMutableSet*)value;


@end
