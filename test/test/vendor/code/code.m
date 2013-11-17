#include "code.h"

@implementation TestMethod

- (CGSize)methodReturningCGSize
{
    return CGSizeMake(1, 2);
}

- (CGRect)methodReturningCGRect
{
    return CGRectMake(1, 2, 3, 4);
}

+ (BOOL)testMethodReturningCGSize:(TestMethod *)testMethod
{
    CGSize size = [testMethod methodReturningCGSize];
    return size.width == 1 && size.height == 2;
}

+ (BOOL)testMethodReturningCGRect:(TestMethod *)testMethod
{
    CGRect rect = [testMethod methodReturningCGRect];
    return rect.origin.x == 1 && rect.origin.y == 2 && rect.size.width == 3 && rect.size.height == 4;
}

+ (BOOL)testMethodAcceptingUIInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return orientation == UIInterfaceOrientationPortrait;
}

+ (BOOL)testMethodAcceptingUIEdgeInsets:(UIEdgeInsets)insets
{
    return YES;
}

+ (BOOL)testMethodAcceptingCFType:(CFStringRef)cfstring
{
    return [(id)cfstring isEqualToString:@"foo"];
}

+ (BOOL)testMethodAcceptingMyStruct4C:(struct MyStruct4C)s
{
    return s.a == 1 && s.b == 2 && s.c == 3 && s.d == 4;
}

+ (BOOL)testMethodAcceptingMyStruct4C:(struct MyStruct4C)s another:(struct MyStruct4C)s2
{
    return [self testMethodAcceptingMyStruct4C:s] && [self testMethodAcceptingMyStruct4C:s2];
}

+ (BOOL)testMethodAcceptingMyStruct4CValue:(NSValue *)value
{
    struct MyStruct4C s;
    [value getValue:&s];
    return [self testMethodAcceptingMyStruct4C:s];
}

+ (id)testMethodCallingBlock:(MyBlock)block
{
    if (block != nil) {
	return block();
    }
    return [NSNumber numberWithInt:42];
}

+ (BOOL)testValueForKey:(id)obj expected:(id)expected
{
    id val = [obj valueForKey:@"foo"];
    return val == expected || (val != nil && [val isEqual:expected]);
}

+ (int)testPointerToStrings:(char **)strs length:(int)len
{
    int total = 0;
    for (int i = 0; i < len; i++) {
	assert(strs[i] != NULL);
	total += atoi(strs[i]);
    }
    return total;
}

- (int)methodReturningLargeInt
{
    return 2147483646;
}

- (id)methodSendingNew:(Class)klass
{
    return [[klass new] autorelease];
}

- (BOOL)testProtocolFlag
{
    return _testProtocolFlag;
}

- (void)setTestProtocolFlag:(BOOL)testFlag
{
    _testProtocolFlag = testFlag;
}

+ (BOOL)testConformsToProtocol:(id <TestConformsToProtocol>)obj
{
    return [obj conformsToProtocol:@protocol(TestConformsToProtocol)];
}

@end

@implementation TestIterator

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id *)stackbuf count:(NSUInteger)len
{
    static NSArray *content = nil;
    if (content == nil) {
	content = [[NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil] retain];
    }
    return [content countByEnumeratingWithState:state objects:stackbuf count:len];
}

@end

int lowerCaseConstant = 42;

@implementation lowerCaseClass
@end

void KreateStackBlock(void (^inputBlock)(ReturnsIntBlock))
{
  int x = 42;
  inputBlock(^{ return x; });
}

ReturnsIntBlock KreateMallocBlock(int input)
{
  return Block_copy(^{ return input * 2; });
}

ReturnsIntBlock KreateGlobalBlock()
{
  return ^{ return 42; };
}