; ModuleID = './src/main.cxx'
source_filename = "./src/main.cxx"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%"class.std::ios_base::Init" = type { i8 }
%"class.std::__cxx11::basic_string" = type { %"struct.std::__cxx11::basic_string<char>::_Alloc_hider", i64, %union.anon }
%"struct.std::__cxx11::basic_string<char>::_Alloc_hider" = type { ptr }
%union.anon = type { i64, [8 x i8] }
%"class.std::allocator" = type { i8 }
%struct.__va_list_tag = type { i32, i32, ptr, ptr }
%"struct.std::forward_iterator_tag" = type { i8 }
%"struct.std::random_access_iterator_tag" = type { i8 }
%struct._Guard = type { ptr }

$_ZNSt7__cxx119to_stringEd = comdat any

$_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_RKS8_ = comdat any

$_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_PKS5_ = comdat any

$_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEPKS5_RKS8_ = comdat any

$_ZN9__gnu_cxx12__to_xstringINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEcEET_PFiPT0_mPKS8_P13__va_list_tagEmSB_z = comdat any

$_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2IPcvEET_S7_RKS3_ = comdat any

$_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPcEEvT_S7_St20forward_iterator_tag = comdat any

$_ZSt19__iterator_categoryIPcENSt15iterator_traitsIT_E17iterator_categoryERKS2_ = comdat any

$_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderD2Ev = comdat any

$_ZSt8distanceIPcENSt15iterator_traitsIT_E15difference_typeES2_S2_ = comdat any

$_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPcEEvT_S7_St20forward_iterator_tagEN6_GuardC2EPS4_ = comdat any

$_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPcEEvT_S7_St20forward_iterator_tagEN6_GuardD2Ev = comdat any

$_ZSt10__distanceIPcENSt15iterator_traitsIT_E15difference_typeES2_S2_St26random_access_iterator_tag = comdat any

$__clang_call_terminate = comdat any

$_ZNSt11char_traitsIcE6lengthEPKc = comdat any

$_ZN9__gnu_cxx14__alloc_traitsISaIcEcE17_S_select_on_copyERKS1_ = comdat any

$_ZNSt16allocator_traitsISaIcEE37select_on_container_copy_constructionERKS0_ = comdat any

@_ZStL8__ioinit = internal global %"class.std::ios_base::Init" zeroinitializer, align 1
@__dso_handle = external hidden global i8
@vert = dso_local global i32 0, align 4
@frag = dso_local global i32 0, align 4
@program = dso_local global i32 0, align 4
@a = dso_local global float 0.000000e+00, align 4
@b = dso_local global float 0.000000e+00, align 4
@frame = dso_local global double 0.000000e+00, align 8
@timet = dso_local global double 0.000000e+00, align 8
@timebase = dso_local global double 0.000000e+00, align 8
@fps = dso_local global double 0.000000e+00, align 8
@ft = dso_local global double 0.000000e+00, align 8
@lpos = dso_local global [4 x float] [float 0x3FF4106240000000, float 0x3FE1AE6C80000000, float 0x3FF0601040000000, float 5.000000e-01], align 16
@.str = private unnamed_addr constant [3 x i8] c"rt\00", align 1
@.str.1 = private unnamed_addr constant [7 x i8] c"FPS : \00", align 1
@.str.2 = private unnamed_addr constant [16 x i8] c" / Frametime : \00", align 1
@.str.3 = private unnamed_addr constant [34 x i8] c"glError in file %s @ line %d: %s\0A\00", align 1
@__glewGetShaderiv = external global ptr, align 8
@__glewGetShaderInfoLog = external global ptr, align 8
@.str.4 = private unnamed_addr constant [4 x i8] c"%s\0A\00", align 1
@__glewGetProgramiv = external global ptr, align 8
@__glewGetProgramInfoLog = external global ptr, align 8
@__glewCreateShader = external global ptr, align 8
@.str.5 = private unnamed_addr constant [18 x i8] c"shaders/vert.glsl\00", align 1
@.str.6 = private unnamed_addr constant [18 x i8] c"shaders/frag.glsl\00", align 1
@__glewShaderSource = external global ptr, align 8
@__glewCompileShader = external global ptr, align 8
@__glewCreateProgram = external global ptr, align 8
@__glewAttachShader = external global ptr, align 8
@__glewLinkProgram = external global ptr, align 8
@__glewUseProgram = external global ptr, align 8
@.str.7 = private unnamed_addr constant [13 x i8] c"ElectroBench\00", align 1
@__glewXSwapIntervalMESA = external global ptr, align 8
@.str.8 = private unnamed_addr constant [15 x i8] c"GL_VERSION_2_0\00", align 1
@.str.9 = private unnamed_addr constant [22 x i8] c"Ready for OpenGL 2.0\0A\00", align 1
@.str.10 = private unnamed_addr constant [26 x i8] c"OpenGL 2.0 not supported\0A\00", align 1
@.str.11 = private unnamed_addr constant [3 x i8] c"%f\00", align 1
@llvm.global_ctors = appending global [1 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 65535, ptr @_GLOBAL__sub_I_main.cxx, ptr null }]

; Function Attrs: noinline uwtable
define internal void @__cxx_global_var_init() #0 section ".text.startup" {
  call void @_ZNSt8ios_base4InitC1Ev(ptr noundef nonnull align 1 dereferenceable(1) @_ZStL8__ioinit)
  %1 = call i32 @__cxa_atexit(ptr @_ZNSt8ios_base4InitD1Ev, ptr @_ZStL8__ioinit, ptr @__dso_handle) #3
  ret void
}

declare void @_ZNSt8ios_base4InitC1Ev(ptr noundef nonnull align 1 dereferenceable(1)) unnamed_addr #1

; Function Attrs: nounwind
declare void @_ZNSt8ios_base4InitD1Ev(ptr noundef nonnull align 1 dereferenceable(1)) unnamed_addr #2

; Function Attrs: nounwind
declare i32 @__cxa_atexit(ptr, ptr, ptr) #3

; Function Attrs: mustprogress noinline optnone uwtable
define dso_local noundef ptr @_Z12textFileReadPc(ptr noundef %0) #4 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  store ptr null, ptr %4, align 8
  store i32 0, ptr %5, align 4
  %6 = load ptr, ptr %2, align 8
  %7 = icmp ne ptr %6, null
  br i1 %7, label %8, label %42

8:                                                ; preds = %1
  %9 = load ptr, ptr %2, align 8
  %10 = call noalias ptr @fopen(ptr noundef %9, ptr noundef @.str)
  store ptr %10, ptr %3, align 8
  %11 = load ptr, ptr %3, align 8
  %12 = icmp ne ptr %11, null
  br i1 %12, label %13, label %41

13:                                               ; preds = %8
  %14 = load ptr, ptr %3, align 8
  %15 = call i32 @fseek(ptr noundef %14, i64 noundef 0, i32 noundef 2)
  %16 = load ptr, ptr %3, align 8
  %17 = call i64 @ftell(ptr noundef %16)
  %18 = trunc i64 %17 to i32
  store i32 %18, ptr %5, align 4
  %19 = load ptr, ptr %3, align 8
  call void @rewind(ptr noundef %19)
  %20 = load i32, ptr %5, align 4
  %21 = icmp sgt i32 %20, 0
  br i1 %21, label %22, label %38

22:                                               ; preds = %13
  %23 = load i32, ptr %5, align 4
  %24 = add nsw i32 %23, 1
  %25 = sext i32 %24 to i64
  %26 = mul i64 1, %25
  %27 = call noalias ptr @malloc(i64 noundef %26) #13
  store ptr %27, ptr %4, align 8
  %28 = load ptr, ptr %4, align 8
  %29 = load i32, ptr %5, align 4
  %30 = sext i32 %29 to i64
  %31 = load ptr, ptr %3, align 8
  %32 = call i64 @fread(ptr noundef %28, i64 noundef 1, i64 noundef %30, ptr noundef %31)
  %33 = trunc i64 %32 to i32
  store i32 %33, ptr %5, align 4
  %34 = load ptr, ptr %4, align 8
  %35 = load i32, ptr %5, align 4
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds i8, ptr %34, i64 %36
  store i8 0, ptr %37, align 1
  br label %38

38:                                               ; preds = %22, %13
  %39 = load ptr, ptr %3, align 8
  %40 = call i32 @fclose(ptr noundef %39)
  br label %41

41:                                               ; preds = %38, %8
  br label %42

42:                                               ; preds = %41, %1
  %43 = load ptr, ptr %4, align 8
  ret ptr %43
}

declare noalias ptr @fopen(ptr noundef, ptr noundef) #1

declare i32 @fseek(ptr noundef, i64 noundef, i32 noundef) #1

declare i64 @ftell(ptr noundef) #1

declare void @rewind(ptr noundef) #1

; Function Attrs: nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #5

declare i64 @fread(ptr noundef, i64 noundef, i64 noundef, ptr noundef) #1

declare i32 @fclose(ptr noundef) #1

; Function Attrs: mustprogress noinline optnone uwtable
define dso_local void @_Z10changeSizeii(i32 noundef %0, i32 noundef %1) #4 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca float, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %6 = load i32, ptr %4, align 4
  %7 = icmp eq i32 %6, 0
  br i1 %7, label %8, label %9

8:                                                ; preds = %2
  store i32 1, ptr %4, align 4
  br label %9

9:                                                ; preds = %8, %2
  %10 = load i32, ptr %3, align 4
  %11 = sitofp i32 %10 to double
  %12 = fmul double 1.000000e+00, %11
  %13 = load i32, ptr %4, align 4
  %14 = sitofp i32 %13 to double
  %15 = fdiv double %12, %14
  %16 = fptrunc double %15 to float
  store float %16, ptr %5, align 4
  call void @glMatrixMode(i32 noundef 5889)
  call void @glLoadIdentity()
  %17 = load i32, ptr %3, align 4
  %18 = load i32, ptr %4, align 4
  call void @glViewport(i32 noundef 0, i32 noundef 0, i32 noundef %17, i32 noundef %18)
  %19 = load float, ptr %5, align 4
  %20 = fpext float %19 to double
  call void @gluPerspective(double noundef 4.500000e+01, double noundef %20, double noundef 1.000000e+00, double noundef 1.000000e+02)
  call void @glMatrixMode(i32 noundef 5888)
  ret void
}

declare void @glMatrixMode(i32 noundef) #1

declare void @glLoadIdentity() #1

declare void @glViewport(i32 noundef, i32 noundef, i32 noundef, i32 noundef) #1

declare void @gluPerspective(double noundef, double noundef, double noundef, double noundef) #1

; Function Attrs: mustprogress noinline optnone uwtable
define dso_local void @_Z11renderScenev() #4 personality ptr @__gxx_personality_v0 {
  %1 = alloca %"class.std::__cxx11::basic_string", align 8
  %2 = alloca %"class.std::__cxx11::basic_string", align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca %"class.std::__cxx11::basic_string", align 8
  %6 = alloca %"class.std::__cxx11::basic_string", align 8
  %7 = alloca %"class.std::__cxx11::basic_string", align 8
  %8 = load double, ptr @frame, align 8
  %9 = fadd double %8, 1.000000e+00
  store double %9, ptr @frame, align 8
  %10 = call i32 @glutGet(i32 noundef 700)
  %11 = sitofp i32 %10 to double
  store double %11, ptr @timet, align 8
  %12 = load double, ptr @timet, align 8
  %13 = load double, ptr @timebase, align 8
  %14 = fsub double %12, %13
  %15 = fcmp ogt double %14, 1.000000e+03
  br i1 %15, label %16, label %57

16:                                               ; preds = %0
  %17 = load double, ptr @frame, align 8
  %18 = fmul double %17, 1.000000e+03
  %19 = load double, ptr @timet, align 8
  %20 = load double, ptr @timebase, align 8
  %21 = fsub double %19, %20
  %22 = fdiv double %18, %21
  store double %22, ptr @fps, align 8
  %23 = load double, ptr @timet, align 8
  store double %23, ptr @timebase, align 8
  store double 0.000000e+00, ptr @frame, align 8
  %24 = load double, ptr @fps, align 8
  %25 = fdiv double 1.000000e+00, %24
  store double %25, ptr @ft, align 8
  %26 = load double, ptr @fps, align 8
  call void @_ZNSt7__cxx119to_stringEd(ptr sret(%"class.std::__cxx11::basic_string") align 8 %1, double noundef %26)
  %27 = load double, ptr @ft, align 8
  invoke void @_ZNSt7__cxx119to_stringEd(ptr sret(%"class.std::__cxx11::basic_string") align 8 %2, double noundef %27)
          to label %28 unwind label %34

28:                                               ; preds = %16
  invoke void @_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEPKS5_RKS8_(ptr sret(%"class.std::__cxx11::basic_string") align 8 %7, ptr noundef @.str.1, ptr noundef nonnull align 8 dereferenceable(32) %1)
          to label %29 unwind label %38

29:                                               ; preds = %28
  invoke void @_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_PKS5_(ptr sret(%"class.std::__cxx11::basic_string") align 8 %6, ptr noundef nonnull align 8 dereferenceable(32) %7, ptr noundef @.str.2)
          to label %30 unwind label %42

30:                                               ; preds = %29
  invoke void @_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_RKS8_(ptr sret(%"class.std::__cxx11::basic_string") align 8 %5, ptr noundef nonnull align 8 dereferenceable(32) %6, ptr noundef nonnull align 8 dereferenceable(32) %2)
          to label %31 unwind label %46

31:                                               ; preds = %30
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(ptr noundef nonnull align 8 dereferenceable(32) %6) #3
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(ptr noundef nonnull align 8 dereferenceable(32) %7) #3
  %32 = call noundef ptr @_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv(ptr noundef nonnull align 8 dereferenceable(32) %5) #3
  invoke void @glutSetWindowTitle(ptr noundef %32)
          to label %33 unwind label %51

33:                                               ; preds = %31
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(ptr noundef nonnull align 8 dereferenceable(32) %5) #3
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(ptr noundef nonnull align 8 dereferenceable(32) %2) #3
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(ptr noundef nonnull align 8 dereferenceable(32) %1) #3
  br label %57

34:                                               ; preds = %16
  %35 = landingpad { ptr, i32 }
          cleanup
  %36 = extractvalue { ptr, i32 } %35, 0
  store ptr %36, ptr %3, align 8
  %37 = extractvalue { ptr, i32 } %35, 1
  store i32 %37, ptr %4, align 4
  br label %56

38:                                               ; preds = %28
  %39 = landingpad { ptr, i32 }
          cleanup
  %40 = extractvalue { ptr, i32 } %39, 0
  store ptr %40, ptr %3, align 8
  %41 = extractvalue { ptr, i32 } %39, 1
  store i32 %41, ptr %4, align 4
  br label %55

42:                                               ; preds = %29
  %43 = landingpad { ptr, i32 }
          cleanup
  %44 = extractvalue { ptr, i32 } %43, 0
  store ptr %44, ptr %3, align 8
  %45 = extractvalue { ptr, i32 } %43, 1
  store i32 %45, ptr %4, align 4
  br label %50

46:                                               ; preds = %30
  %47 = landingpad { ptr, i32 }
          cleanup
  %48 = extractvalue { ptr, i32 } %47, 0
  store ptr %48, ptr %3, align 8
  %49 = extractvalue { ptr, i32 } %47, 1
  store i32 %49, ptr %4, align 4
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(ptr noundef nonnull align 8 dereferenceable(32) %6) #3
  br label %50

50:                                               ; preds = %46, %42
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(ptr noundef nonnull align 8 dereferenceable(32) %7) #3
  br label %55

51:                                               ; preds = %31
  %52 = landingpad { ptr, i32 }
          cleanup
  %53 = extractvalue { ptr, i32 } %52, 0
  store ptr %53, ptr %3, align 8
  %54 = extractvalue { ptr, i32 } %52, 1
  store i32 %54, ptr %4, align 4
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(ptr noundef nonnull align 8 dereferenceable(32) %5) #3
  br label %55

55:                                               ; preds = %51, %50, %38
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(ptr noundef nonnull align 8 dereferenceable(32) %2) #3
  br label %56

56:                                               ; preds = %55, %34
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(ptr noundef nonnull align 8 dereferenceable(32) %1) #3
  br label %66

57:                                               ; preds = %33, %0
  call void @glClear(i32 noundef 16640)
  call void @glEnable(i32 noundef 32925)
  call void @glLoadIdentity()
  call void @gluLookAt(double noundef 0.000000e+00, double noundef 5.000000e+00, double noundef 5.000000e+00, double noundef 0.000000e+00, double noundef 0.000000e+00, double noundef 0.000000e+00, double noundef 0.000000e+00, double noundef 1.000000e+00, double noundef 0.000000e+00)
  %58 = load float, ptr @a, align 4
  call void @glRotatef(float noundef %58, float noundef 1.200000e+01, float noundef 1.500000e+01, float noundef 9.000000e+00)
  %59 = load float, ptr @b, align 4
  call void @glRotatef(float noundef %59, float noundef 1.300000e+01, float noundef 1.400000e+01, float noundef 8.000000e+00)
  call void @glutSolidTeapot(double noundef 2.400000e+00)
  %60 = load float, ptr @a, align 4
  %61 = fadd float %60, 1.000000e+00
  store float %61, ptr @a, align 4
  %62 = load float, ptr @b, align 4
  %63 = fpext float %62 to double
  %64 = fadd double %63, 1.500000e+00
  %65 = fptrunc double %64 to float
  store float %65, ptr @b, align 4
  call void @glutSwapBuffers()
  ret void

66:                                               ; preds = %56
  %67 = load ptr, ptr %3, align 8
  %68 = load i32, ptr %4, align 4
  %69 = insertvalue { ptr, i32 } undef, ptr %67, 0
  %70 = insertvalue { ptr, i32 } %69, i32 %68, 1
  resume { ptr, i32 } %70
}

declare i32 @glutGet(i32 noundef) #1

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZNSt7__cxx119to_stringEd(ptr noalias sret(%"class.std::__cxx11::basic_string") align 8 %0, double noundef %1) #4 comdat {
  %3 = alloca ptr, align 8
  %4 = alloca double, align 8
  %5 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store double %1, ptr %4, align 8
  store i32 328, ptr %5, align 4
  %6 = load double, ptr %4, align 8
  call void (ptr, ptr, i64, ptr, ...) @_ZN9__gnu_cxx12__to_xstringINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEcEET_PFiPT0_mPKS8_P13__va_list_tagEmSB_z(ptr sret(%"class.std::__cxx11::basic_string") align 8 %0, ptr noundef @vsnprintf, i64 noundef 328, ptr noundef @.str.11, double noundef %6)
  ret void
}

declare i32 @__gxx_personality_v0(...)

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_RKS8_(ptr noalias sret(%"class.std::__cxx11::basic_string") align 8 %0, ptr noundef nonnull align 8 dereferenceable(32) %1, ptr noundef nonnull align 8 dereferenceable(32) %2) #4 comdat {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %7 = load ptr, ptr %5, align 8
  %8 = load ptr, ptr %6, align 8
  %9 = call noundef nonnull align 8 dereferenceable(32) ptr @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE6appendERKS4_(ptr noundef nonnull align 8 dereferenceable(32) %7, ptr noundef nonnull align 8 dereferenceable(32) %8)
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1EOS4_(ptr noundef nonnull align 8 dereferenceable(32) %0, ptr noundef nonnull align 8 dereferenceable(32) %9) #3
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEOS8_PKS5_(ptr noalias sret(%"class.std::__cxx11::basic_string") align 8 %0, ptr noundef nonnull align 8 dereferenceable(32) %1, ptr noundef %2) #4 comdat {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %7 = load ptr, ptr %5, align 8
  %8 = load ptr, ptr %6, align 8
  %9 = call noundef nonnull align 8 dereferenceable(32) ptr @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE6appendEPKc(ptr noundef nonnull align 8 dereferenceable(32) %7, ptr noundef %8)
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1EOS4_(ptr noundef nonnull align 8 dereferenceable(32) %0, ptr noundef nonnull align 8 dereferenceable(32) %9) #3
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEPKS5_RKS8_(ptr noalias sret(%"class.std::__cxx11::basic_string") align 8 %0, ptr noundef %1, ptr noundef nonnull align 8 dereferenceable(32) %2) #4 comdat personality ptr @__gxx_personality_v0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i64, align 8
  %8 = alloca i1, align 1
  %9 = alloca %"class.std::allocator", align 1
  %10 = alloca %"class.std::allocator", align 1
  %11 = alloca ptr, align 8
  %12 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %13 = load ptr, ptr %5, align 8
  %14 = call noundef i64 @_ZNSt11char_traitsIcE6lengthEPKc(ptr noundef %13)
  store i64 %14, ptr %7, align 8
  store i1 false, ptr %8, align 1
  %15 = load ptr, ptr %6, align 8
  call void @_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13get_allocatorEv(ptr sret(%"class.std::allocator") align 1 %10, ptr noundef nonnull align 8 dereferenceable(32) %15) #3
  invoke void @_ZN9__gnu_cxx14__alloc_traitsISaIcEcE17_S_select_on_copyERKS1_(ptr sret(%"class.std::allocator") align 1 %9, ptr noundef nonnull align 1 dereferenceable(1) %10)
          to label %16 unwind label %30

16:                                               ; preds = %3
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1ERKS3_(ptr noundef nonnull align 8 dereferenceable(32) %0, ptr noundef nonnull align 1 dereferenceable(1) %9) #3
  call void @_ZNSaIcED1Ev(ptr noundef nonnull align 1 dereferenceable(1) %9) #3
  call void @_ZNSaIcED1Ev(ptr noundef nonnull align 1 dereferenceable(1) %10) #3
  %17 = load i64, ptr %7, align 8
  %18 = load ptr, ptr %6, align 8
  %19 = call noundef i64 @_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4sizeEv(ptr noundef nonnull align 8 dereferenceable(32) %18) #3
  %20 = add i64 %17, %19
  invoke void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE7reserveEm(ptr noundef nonnull align 8 dereferenceable(32) %0, i64 noundef %20)
          to label %21 unwind label %34

21:                                               ; preds = %16
  %22 = load ptr, ptr %5, align 8
  %23 = load i64, ptr %7, align 8
  %24 = invoke noundef nonnull align 8 dereferenceable(32) ptr @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE6appendEPKcm(ptr noundef nonnull align 8 dereferenceable(32) %0, ptr noundef %22, i64 noundef %23)
          to label %25 unwind label %34

25:                                               ; preds = %21
  %26 = load ptr, ptr %6, align 8
  %27 = invoke noundef nonnull align 8 dereferenceable(32) ptr @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE6appendERKS4_(ptr noundef nonnull align 8 dereferenceable(32) %0, ptr noundef nonnull align 8 dereferenceable(32) %26)
          to label %28 unwind label %34

28:                                               ; preds = %25
  store i1 true, ptr %8, align 1
  %29 = load i1, ptr %8, align 1
  br i1 %29, label %39, label %38

30:                                               ; preds = %3
  %31 = landingpad { ptr, i32 }
          cleanup
  %32 = extractvalue { ptr, i32 } %31, 0
  store ptr %32, ptr %11, align 8
  %33 = extractvalue { ptr, i32 } %31, 1
  store i32 %33, ptr %12, align 4
  call void @_ZNSaIcED1Ev(ptr noundef nonnull align 1 dereferenceable(1) %10) #3
  br label %40

34:                                               ; preds = %25, %21, %16
  %35 = landingpad { ptr, i32 }
          cleanup
  %36 = extractvalue { ptr, i32 } %35, 0
  store ptr %36, ptr %11, align 8
  %37 = extractvalue { ptr, i32 } %35, 1
  store i32 %37, ptr %12, align 4
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(ptr noundef nonnull align 8 dereferenceable(32) %0) #3
  br label %40

38:                                               ; preds = %28
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(ptr noundef nonnull align 8 dereferenceable(32) %0) #3
  br label %39

39:                                               ; preds = %38, %28
  ret void

40:                                               ; preds = %34, %30
  %41 = load ptr, ptr %11, align 8
  %42 = load i32, ptr %12, align 4
  %43 = insertvalue { ptr, i32 } undef, ptr %41, 0
  %44 = insertvalue { ptr, i32 } %43, i32 %42, 1
  resume { ptr, i32 } %44
}

; Function Attrs: nounwind
declare void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(ptr noundef nonnull align 8 dereferenceable(32)) unnamed_addr #2

declare void @glutSetWindowTitle(ptr noundef) #1

; Function Attrs: nounwind
declare noundef ptr @_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv(ptr noundef nonnull align 8 dereferenceable(32)) #2

declare void @glClear(i32 noundef) #1

declare void @glEnable(i32 noundef) #1

declare void @gluLookAt(double noundef, double noundef, double noundef, double noundef, double noundef, double noundef, double noundef, double noundef, double noundef) #1

declare void @glRotatef(float noundef, float noundef, float noundef, float noundef) #1

declare void @glutSolidTeapot(double noundef) #1

declare void @glutSwapBuffers() #1

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define dso_local void @_Z11processKeyshii(i8 noundef zeroext %0, i32 noundef %1, i32 noundef %2) #6 {
  %4 = alloca i8, align 1
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i8 %0, ptr %4, align 1
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  %7 = load i8, ptr %4, align 1
  %8 = zext i8 %7 to i32
  %9 = icmp eq i32 %8, 27
  br i1 %9, label %10, label %11

10:                                               ; preds = %3
  call void @exit(i32 noundef 0) #14
  unreachable

11:                                               ; preds = %3
  ret void
}

; Function Attrs: noreturn nounwind
declare void @exit(i32 noundef) #7

; Function Attrs: mustprogress noinline optnone uwtable
define dso_local noundef i32 @_Z12printGLErrorPci(ptr noundef %0, i32 noundef %1) #4 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  store i32 0, ptr %6, align 4
  %7 = call i32 @glGetError()
  store i32 %7, ptr %5, align 4
  br label %8

8:                                                ; preds = %11, %2
  %9 = load i32, ptr %5, align 4
  %10 = icmp ne i32 %9, 0
  br i1 %10, label %11, label %18

11:                                               ; preds = %8
  %12 = load ptr, ptr %3, align 8
  %13 = load i32, ptr %4, align 4
  %14 = load i32, ptr %5, align 4
  %15 = call ptr @gluErrorString(i32 noundef %14)
  %16 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, ptr noundef %12, i32 noundef %13, ptr noundef %15)
  store i32 1, ptr %6, align 4
  %17 = call i32 @glGetError()
  store i32 %17, ptr %5, align 4
  br label %8, !llvm.loop !6

18:                                               ; preds = %8
  %19 = load i32, ptr %6, align 4
  ret i32 %19
}

declare i32 @glGetError() #1

declare i32 @printf(ptr noundef, ...) #1

declare ptr @gluErrorString(i32 noundef) #1

; Function Attrs: mustprogress noinline optnone uwtable
define dso_local void @_Z18printShaderInfoLogj(i32 noundef %0) #4 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  store i32 %0, ptr %2, align 4
  store i32 0, ptr %3, align 4
  store i32 0, ptr %4, align 4
  %6 = load ptr, ptr @__glewGetShaderiv, align 8
  %7 = load i32, ptr %2, align 4
  call void %6(i32 noundef %7, i32 noundef 35716, ptr noundef %3)
  %8 = load i32, ptr %3, align 4
  %9 = icmp sgt i32 %8, 0
  br i1 %9, label %10, label %21

10:                                               ; preds = %1
  %11 = load i32, ptr %3, align 4
  %12 = sext i32 %11 to i64
  %13 = call noalias ptr @malloc(i64 noundef %12) #13
  store ptr %13, ptr %5, align 8
  %14 = load ptr, ptr @__glewGetShaderInfoLog, align 8
  %15 = load i32, ptr %2, align 4
  %16 = load i32, ptr %3, align 4
  %17 = load ptr, ptr %5, align 8
  call void %14(i32 noundef %15, i32 noundef %16, ptr noundef %4, ptr noundef %17)
  %18 = load ptr, ptr %5, align 8
  %19 = call i32 (ptr, ...) @printf(ptr noundef @.str.4, ptr noundef %18)
  %20 = load ptr, ptr %5, align 8
  call void @free(ptr noundef %20) #3
  br label %21

21:                                               ; preds = %10, %1
  ret void
}

; Function Attrs: nounwind
declare void @free(ptr noundef) #2

; Function Attrs: mustprogress noinline optnone uwtable
define dso_local void @_Z19printProgramInfoLogj(i32 noundef %0) #4 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  store i32 %0, ptr %2, align 4
  store i32 0, ptr %3, align 4
  store i32 0, ptr %4, align 4
  %6 = load ptr, ptr @__glewGetProgramiv, align 8
  %7 = load i32, ptr %2, align 4
  call void %6(i32 noundef %7, i32 noundef 35716, ptr noundef %3)
  %8 = load i32, ptr %3, align 4
  %9 = icmp sgt i32 %8, 0
  br i1 %9, label %10, label %21

10:                                               ; preds = %1
  %11 = load i32, ptr %3, align 4
  %12 = sext i32 %11 to i64
  %13 = call noalias ptr @malloc(i64 noundef %12) #13
  store ptr %13, ptr %5, align 8
  %14 = load ptr, ptr @__glewGetProgramInfoLog, align 8
  %15 = load i32, ptr %2, align 4
  %16 = load i32, ptr %3, align 4
  %17 = load ptr, ptr %5, align 8
  call void %14(i32 noundef %15, i32 noundef %16, ptr noundef %4, ptr noundef %17)
  %18 = load ptr, ptr %5, align 8
  %19 = call i32 (ptr, ...) @printf(ptr noundef @.str.4, ptr noundef %18)
  %20 = load ptr, ptr %5, align 8
  call void @free(ptr noundef %20) #3
  br label %21

21:                                               ; preds = %10, %1
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define dso_local void @_Z10setShadersv() #4 {
  %1 = alloca ptr, align 8
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr null, ptr %1, align 8
  store ptr null, ptr %2, align 8
  %5 = load ptr, ptr @__glewCreateShader, align 8
  %6 = call i32 %5(i32 noundef 35633)
  store i32 %6, ptr @vert, align 4
  %7 = load ptr, ptr @__glewCreateShader, align 8
  %8 = call i32 %7(i32 noundef 35632)
  store i32 %8, ptr @frag, align 4
  %9 = call noundef ptr @_Z12textFileReadPc(ptr noundef @.str.5)
  store ptr %9, ptr %1, align 8
  %10 = call noundef ptr @_Z12textFileReadPc(ptr noundef @.str.6)
  store ptr %10, ptr %2, align 8
  %11 = load ptr, ptr %1, align 8
  store ptr %11, ptr %3, align 8
  %12 = load ptr, ptr %2, align 8
  store ptr %12, ptr %4, align 8
  %13 = load ptr, ptr @__glewShaderSource, align 8
  %14 = load i32, ptr @vert, align 4
  call void %13(i32 noundef %14, i32 noundef 1, ptr noundef %3, ptr noundef null)
  %15 = load ptr, ptr @__glewShaderSource, align 8
  %16 = load i32, ptr @frag, align 4
  call void %15(i32 noundef %16, i32 noundef 1, ptr noundef %4, ptr noundef null)
  %17 = load ptr, ptr %1, align 8
  call void @free(ptr noundef %17) #3
  %18 = load ptr, ptr %2, align 8
  call void @free(ptr noundef %18) #3
  %19 = load ptr, ptr @__glewCompileShader, align 8
  %20 = load i32, ptr @vert, align 4
  call void %19(i32 noundef %20)
  %21 = load ptr, ptr @__glewCompileShader, align 8
  %22 = load i32, ptr @frag, align 4
  call void %21(i32 noundef %22)
  %23 = load i32, ptr @vert, align 4
  call void @_Z18printShaderInfoLogj(i32 noundef %23)
  %24 = load i32, ptr @frag, align 4
  call void @_Z18printShaderInfoLogj(i32 noundef %24)
  %25 = load ptr, ptr @__glewCreateProgram, align 8
  %26 = call i32 %25()
  store i32 %26, ptr @program, align 4
  %27 = load ptr, ptr @__glewAttachShader, align 8
  %28 = load i32, ptr @program, align 4
  %29 = load i32, ptr @vert, align 4
  call void %27(i32 noundef %28, i32 noundef %29)
  %30 = load ptr, ptr @__glewAttachShader, align 8
  %31 = load i32, ptr @program, align 4
  %32 = load i32, ptr @frag, align 4
  call void %30(i32 noundef %31, i32 noundef %32)
  %33 = load ptr, ptr @__glewLinkProgram, align 8
  %34 = load i32, ptr @program, align 4
  call void %33(i32 noundef %34)
  %35 = load i32, ptr @program, align 4
  call void @_Z19printProgramInfoLogj(i32 noundef %35)
  %36 = load ptr, ptr @__glewUseProgram, align 8
  %37 = load i32, ptr @program, align 4
  call void %36(i32 noundef %37)
  ret void
}

; Function Attrs: mustprogress noinline norecurse optnone uwtable
define dso_local noundef i32 @main(i32 noundef %0, ptr noundef %1) #8 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  %6 = load ptr, ptr %5, align 8
  call void @glutInit(ptr noundef %4, ptr noundef %6)
  call void @glutInitDisplayMode(i32 noundef 146)
  call void @glutInitWindowSize(i32 noundef 2560, i32 noundef 1440)
  %7 = call i32 @glutCreateWindow(ptr noundef @.str.7)
  call void @glutDisplayFunc(ptr noundef @_Z11renderScenev)
  call void @glutIdleFunc(ptr noundef @_Z11renderScenev)
  call void @glutReshapeFunc(ptr noundef @_Z10changeSizeii)
  call void @glutKeyboardFunc(ptr noundef @_Z11processKeyshii)
  call void @glClearColor(float noundef 0.000000e+00, float noundef 0.000000e+00, float noundef 0.000000e+00, float noundef 1.000000e+00)
  %8 = call i32 @glewInit()
  %9 = call i32 @glxewInit()
  %10 = load ptr, ptr @__glewXSwapIntervalMESA, align 8
  %11 = call i32 %10(i32 noundef 0)
  %12 = call zeroext i8 @glewIsSupported(ptr noundef @.str.8)
  %13 = icmp ne i8 %12, 0
  br i1 %13, label %14, label %16

14:                                               ; preds = %2
  %15 = call i32 (ptr, ...) @printf(ptr noundef @.str.9)
  br label %18

16:                                               ; preds = %2
  %17 = call i32 (ptr, ...) @printf(ptr noundef @.str.10)
  call void @exit(i32 noundef 1) #14
  unreachable

18:                                               ; preds = %14
  call void @_Z10setShadersv()
  call void @glutMainLoop()
  ret i32 0
}

declare void @glutInit(ptr noundef, ptr noundef) #1

declare void @glutInitDisplayMode(i32 noundef) #1

declare void @glutInitWindowSize(i32 noundef, i32 noundef) #1

declare i32 @glutCreateWindow(ptr noundef) #1

declare void @glutDisplayFunc(ptr noundef) #1

declare void @glutIdleFunc(ptr noundef) #1

declare void @glutReshapeFunc(ptr noundef) #1

declare void @glutKeyboardFunc(ptr noundef) #1

declare void @glClearColor(float noundef, float noundef, float noundef, float noundef) #1

declare i32 @glewInit() #1

declare i32 @glxewInit() #1

declare zeroext i8 @glewIsSupported(ptr noundef) #1

declare void @glutMainLoop() #1

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZN9__gnu_cxx12__to_xstringINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEcEET_PFiPT0_mPKS8_P13__va_list_tagEmSB_z(ptr noalias sret(%"class.std::__cxx11::basic_string") align 8 %0, ptr noundef %1, i64 noundef %2, ptr noundef %3, ...) #4 comdat personality ptr @__gxx_personality_v0 {
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i64, align 8
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = alloca [1 x %struct.__va_list_tag], align 16
  %11 = alloca i32, align 4
  %12 = alloca %"class.std::allocator", align 1
  %13 = alloca ptr, align 8
  %14 = alloca i32, align 4
  store ptr %0, ptr %5, align 8
  store ptr %1, ptr %6, align 8
  store i64 %2, ptr %7, align 8
  store ptr %3, ptr %8, align 8
  %15 = load i64, ptr %7, align 8
  %16 = mul i64 1, %15
  %17 = alloca i8, i64 %16, align 16
  store ptr %17, ptr %9, align 8
  %18 = getelementptr inbounds [1 x %struct.__va_list_tag], ptr %10, i64 0, i64 0
  call void @llvm.va_start(ptr %18)
  %19 = load ptr, ptr %6, align 8
  %20 = load ptr, ptr %9, align 8
  %21 = load i64, ptr %7, align 8
  %22 = load ptr, ptr %8, align 8
  %23 = getelementptr inbounds [1 x %struct.__va_list_tag], ptr %10, i64 0, i64 0
  %24 = call noundef i32 %19(ptr noundef %20, i64 noundef %21, ptr noundef %22, ptr noundef %23)
  store i32 %24, ptr %11, align 4
  %25 = getelementptr inbounds [1 x %struct.__va_list_tag], ptr %10, i64 0, i64 0
  call void @llvm.va_end(ptr %25)
  %26 = load ptr, ptr %9, align 8
  %27 = load ptr, ptr %9, align 8
  %28 = load i32, ptr %11, align 4
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds i8, ptr %27, i64 %29
  call void @_ZNSaIcEC1Ev(ptr noundef nonnull align 1 dereferenceable(1) %12) #3
  invoke void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2IPcvEET_S7_RKS3_(ptr noundef nonnull align 8 dereferenceable(32) %0, ptr noundef %26, ptr noundef %30, ptr noundef nonnull align 1 dereferenceable(1) %12)
          to label %31 unwind label %32

31:                                               ; preds = %4
  call void @_ZNSaIcED1Ev(ptr noundef nonnull align 1 dereferenceable(1) %12) #3
  ret void

32:                                               ; preds = %4
  %33 = landingpad { ptr, i32 }
          cleanup
  %34 = extractvalue { ptr, i32 } %33, 0
  store ptr %34, ptr %13, align 8
  %35 = extractvalue { ptr, i32 } %33, 1
  store i32 %35, ptr %14, align 4
  call void @_ZNSaIcED1Ev(ptr noundef nonnull align 1 dereferenceable(1) %12) #3
  br label %36

36:                                               ; preds = %32
  %37 = load ptr, ptr %13, align 8
  %38 = load i32, ptr %14, align 4
  %39 = insertvalue { ptr, i32 } undef, ptr %37, 0
  %40 = insertvalue { ptr, i32 } %39, i32 %38, 1
  resume { ptr, i32 } %40
}

; Function Attrs: nounwind
declare i32 @vsnprintf(ptr noundef, i64 noundef, ptr noundef, ptr noundef) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_start(ptr) #9

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_end(ptr) #9

; Function Attrs: nounwind
declare void @_ZNSaIcEC1Ev(ptr noundef nonnull align 1 dereferenceable(1)) unnamed_addr #2

; Function Attrs: noinline optnone uwtable
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2IPcvEET_S7_RKS3_(ptr noundef nonnull align 8 dereferenceable(32) %0, ptr noundef %1, ptr noundef %2, ptr noundef nonnull align 1 dereferenceable(1) %3) unnamed_addr #10 comdat align 2 personality ptr @__gxx_personality_v0 {
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca %"struct.std::forward_iterator_tag", align 1
  %10 = alloca %"struct.std::random_access_iterator_tag", align 1
  %11 = alloca ptr, align 8
  %12 = alloca i32, align 4
  %13 = alloca %"struct.std::random_access_iterator_tag", align 1
  store ptr %0, ptr %5, align 8
  store ptr %1, ptr %6, align 8
  store ptr %2, ptr %7, align 8
  store ptr %3, ptr %8, align 8
  %14 = load ptr, ptr %5, align 8
  %15 = getelementptr inbounds %"class.std::__cxx11::basic_string", ptr %14, i32 0, i32 0
  %16 = call noundef ptr @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_M_local_dataEv(ptr noundef nonnull align 8 dereferenceable(32) %14)
  %17 = load ptr, ptr %8, align 8
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderC1EPcRKS3_(ptr noundef nonnull align 8 dereferenceable(8) %15, ptr noundef %16, ptr noundef nonnull align 1 dereferenceable(1) %17)
  %18 = load ptr, ptr %6, align 8
  %19 = load ptr, ptr %7, align 8
  invoke void @_ZSt19__iterator_categoryIPcENSt15iterator_traitsIT_E17iterator_categoryERKS2_(ptr noundef nonnull align 8 dereferenceable(8) %6)
          to label %20 unwind label %22

20:                                               ; preds = %4
  invoke void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPcEEvT_S7_St20forward_iterator_tag(ptr noundef nonnull align 8 dereferenceable(32) %14, ptr noundef %18, ptr noundef %19)
          to label %21 unwind label %22

21:                                               ; preds = %20
  ret void

22:                                               ; preds = %20, %4
  %23 = landingpad { ptr, i32 }
          cleanup
  %24 = extractvalue { ptr, i32 } %23, 0
  store ptr %24, ptr %11, align 8
  %25 = extractvalue { ptr, i32 } %23, 1
  store i32 %25, ptr %12, align 4
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderD2Ev(ptr noundef nonnull align 8 dereferenceable(8) %15) #3
  br label %26

26:                                               ; preds = %22
  %27 = load ptr, ptr %11, align 8
  %28 = load i32, ptr %12, align 4
  %29 = insertvalue { ptr, i32 } undef, ptr %27, 0
  %30 = insertvalue { ptr, i32 } %29, i32 %28, 1
  resume { ptr, i32 } %30
}

; Function Attrs: nounwind
declare void @_ZNSaIcED1Ev(ptr noundef nonnull align 1 dereferenceable(1)) unnamed_addr #2

declare noundef ptr @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_M_local_dataEv(ptr noundef nonnull align 8 dereferenceable(32)) #1

declare void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderC1EPcRKS3_(ptr noundef nonnull align 8 dereferenceable(8), ptr noundef, ptr noundef nonnull align 1 dereferenceable(1)) unnamed_addr #1

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPcEEvT_S7_St20forward_iterator_tag(ptr noundef nonnull align 8 dereferenceable(32) %0, ptr noundef %1, ptr noundef %2) #4 comdat align 2 personality ptr @__gxx_personality_v0 {
  %4 = alloca ptr, align 8
  %5 = alloca %"struct.std::forward_iterator_tag", align 1
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca i64, align 8
  %10 = alloca %struct._Guard, align 8
  %11 = alloca ptr, align 8
  %12 = alloca i32, align 4
  store ptr %0, ptr %6, align 8
  store ptr %1, ptr %7, align 8
  store ptr %2, ptr %8, align 8
  %13 = load ptr, ptr %6, align 8
  %14 = load ptr, ptr %7, align 8
  %15 = load ptr, ptr %8, align 8
  %16 = call noundef i64 @_ZSt8distanceIPcENSt15iterator_traitsIT_E15difference_typeES2_S2_(ptr noundef %14, ptr noundef %15)
  store i64 %16, ptr %9, align 8
  %17 = load i64, ptr %9, align 8
  %18 = icmp ugt i64 %17, 15
  br i1 %18, label %19, label %22

19:                                               ; preds = %3
  %20 = call noundef ptr @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_createERmm(ptr noundef nonnull align 8 dereferenceable(32) %13, ptr noundef nonnull align 8 dereferenceable(8) %9, i64 noundef 0)
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE7_M_dataEPc(ptr noundef nonnull align 8 dereferenceable(32) %13, ptr noundef %20)
  %21 = load i64, ptr %9, align 8
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE11_M_capacityEm(ptr noundef nonnull align 8 dereferenceable(32) %13, i64 noundef %21)
  br label %29

22:                                               ; preds = %3
  store ptr %13, ptr %4, align 8
  %23 = load ptr, ptr %4, align 8
  %24 = invoke noundef ptr @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_M_local_dataEv(ptr noundef nonnull align 8 dereferenceable(32) %23)
          to label %28 unwind label %25

25:                                               ; preds = %22
  %26 = landingpad { ptr, i32 }
          catch ptr null
  %27 = extractvalue { ptr, i32 } %26, 0
  call void @__clang_call_terminate(ptr %27) #14
  unreachable

28:                                               ; preds = %22
  br label %29

29:                                               ; preds = %28, %19
  call void @_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPcEEvT_S7_St20forward_iterator_tagEN6_GuardC2EPS4_(ptr noundef nonnull align 8 dereferenceable(8) %10, ptr noundef %13)
  %30 = invoke noundef ptr @_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE7_M_dataEv(ptr noundef nonnull align 8 dereferenceable(32) %13)
          to label %31 unwind label %37

31:                                               ; preds = %29
  %32 = load ptr, ptr %7, align 8
  %33 = load ptr, ptr %8, align 8
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_(ptr noundef %30, ptr noundef %32, ptr noundef %33) #3
  %34 = getelementptr inbounds %struct._Guard, ptr %10, i32 0, i32 0
  store ptr null, ptr %34, align 8
  %35 = load i64, ptr %9, align 8
  invoke void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_M_set_lengthEm(ptr noundef nonnull align 8 dereferenceable(32) %13, i64 noundef %35)
          to label %36 unwind label %37

36:                                               ; preds = %31
  call void @_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPcEEvT_S7_St20forward_iterator_tagEN6_GuardD2Ev(ptr noundef nonnull align 8 dereferenceable(8) %10) #3
  ret void

37:                                               ; preds = %31, %29
  %38 = landingpad { ptr, i32 }
          cleanup
  %39 = extractvalue { ptr, i32 } %38, 0
  store ptr %39, ptr %11, align 8
  %40 = extractvalue { ptr, i32 } %38, 1
  store i32 %40, ptr %12, align 4
  call void @_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPcEEvT_S7_St20forward_iterator_tagEN6_GuardD2Ev(ptr noundef nonnull align 8 dereferenceable(8) %10) #3
  br label %41

41:                                               ; preds = %37
  %42 = load ptr, ptr %11, align 8
  %43 = load i32, ptr %12, align 4
  %44 = insertvalue { ptr, i32 } undef, ptr %42, 0
  %45 = insertvalue { ptr, i32 } %44, i32 %43, 1
  resume { ptr, i32 } %45
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZSt19__iterator_categoryIPcENSt15iterator_traitsIT_E17iterator_categoryERKS2_(ptr noundef nonnull align 8 dereferenceable(8) %0) #6 comdat {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderD2Ev(ptr noundef nonnull align 8 dereferenceable(8) %0) unnamed_addr #11 comdat align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  call void @_ZNSaIcED2Ev(ptr noundef nonnull align 1 dereferenceable(1) %3) #3
  ret void
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local noundef i64 @_ZSt8distanceIPcENSt15iterator_traitsIT_E15difference_typeES2_S2_(ptr noundef %0, ptr noundef %1) #4 comdat {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca %"struct.std::random_access_iterator_tag", align 1
  %6 = alloca %"struct.std::random_access_iterator_tag", align 1
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %7 = load ptr, ptr %3, align 8
  %8 = load ptr, ptr %4, align 8
  call void @_ZSt19__iterator_categoryIPcENSt15iterator_traitsIT_E17iterator_categoryERKS2_(ptr noundef nonnull align 8 dereferenceable(8) %3)
  %9 = call noundef i64 @_ZSt10__distanceIPcENSt15iterator_traitsIT_E15difference_typeES2_S2_St26random_access_iterator_tag(ptr noundef %7, ptr noundef %8)
  ret i64 %9
}

declare void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE7_M_dataEPc(ptr noundef nonnull align 8 dereferenceable(32), ptr noundef) #1

declare noundef ptr @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_createERmm(ptr noundef nonnull align 8 dereferenceable(32), ptr noundef nonnull align 8 dereferenceable(8), i64 noundef) #1

declare void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE11_M_capacityEm(ptr noundef nonnull align 8 dereferenceable(32), i64 noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPcEEvT_S7_St20forward_iterator_tagEN6_GuardC2EPS4_(ptr noundef nonnull align 8 dereferenceable(8) %0, ptr noundef %1) unnamed_addr #11 comdat align 2 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = getelementptr inbounds %struct._Guard, ptr %5, i32 0, i32 0
  %7 = load ptr, ptr %4, align 8
  store ptr %7, ptr %6, align 8
  ret void
}

; Function Attrs: nounwind
declare void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_(ptr noundef, ptr noundef, ptr noundef) #2

declare noundef ptr @_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE7_M_dataEv(ptr noundef nonnull align 8 dereferenceable(32)) #1

declare void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_M_set_lengthEm(ptr noundef nonnull align 8 dereferenceable(32), i64 noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPcEEvT_S7_St20forward_iterator_tagEN6_GuardD2Ev(ptr noundef nonnull align 8 dereferenceable(8) %0) unnamed_addr #11 comdat align 2 personality ptr @__gxx_personality_v0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %struct._Guard, ptr %3, i32 0, i32 0
  %5 = load ptr, ptr %4, align 8
  %6 = icmp ne ptr %5, null
  br i1 %6, label %7, label %11

7:                                                ; preds = %1
  %8 = getelementptr inbounds %struct._Guard, ptr %3, i32 0, i32 0
  %9 = load ptr, ptr %8, align 8
  invoke void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv(ptr noundef nonnull align 8 dereferenceable(32) %9)
          to label %10 unwind label %12

10:                                               ; preds = %7
  br label %11

11:                                               ; preds = %10, %1
  ret void

12:                                               ; preds = %7
  %13 = landingpad { ptr, i32 }
          catch ptr null
  %14 = extractvalue { ptr, i32 } %13, 0
  call void @__clang_call_terminate(ptr %14) #14
  unreachable
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local noundef i64 @_ZSt10__distanceIPcENSt15iterator_traitsIT_E15difference_typeES2_S2_St26random_access_iterator_tag(ptr noundef %0, ptr noundef %1) #6 comdat {
  %3 = alloca %"struct.std::random_access_iterator_tag", align 1
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  %6 = load ptr, ptr %5, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = ptrtoint ptr %6 to i64
  %9 = ptrtoint ptr %7 to i64
  %10 = sub i64 %8, %9
  ret i64 %10
}

; Function Attrs: noinline noreturn nounwind
define linkonce_odr hidden void @__clang_call_terminate(ptr %0) #12 comdat {
  %2 = call ptr @__cxa_begin_catch(ptr %0) #3
  call void @_ZSt9terminatev() #14
  unreachable
}

declare ptr @__cxa_begin_catch(ptr)

declare void @_ZSt9terminatev()

declare void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv(ptr noundef nonnull align 8 dereferenceable(32)) #1

; Function Attrs: nounwind
declare void @_ZNSaIcED2Ev(ptr noundef nonnull align 1 dereferenceable(1)) unnamed_addr #2

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local noundef i64 @_ZNSt11char_traitsIcE6lengthEPKc(ptr noundef %0) #6 comdat align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call i64 @strlen(ptr noundef %3) #3
  ret i64 %4
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local void @_ZN9__gnu_cxx14__alloc_traitsISaIcEcE17_S_select_on_copyERKS1_(ptr noalias sret(%"class.std::allocator") align 1 %0, ptr noundef nonnull align 1 dereferenceable(1) %1) #4 comdat align 2 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %4, align 8
  call void @_ZNSt16allocator_traitsISaIcEE37select_on_container_copy_constructionERKS0_(ptr sret(%"class.std::allocator") align 1 %0, ptr noundef nonnull align 1 dereferenceable(1) %5)
  ret void
}

; Function Attrs: nounwind
declare void @_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13get_allocatorEv(ptr sret(%"class.std::allocator") align 1, ptr noundef nonnull align 8 dereferenceable(32)) #2

; Function Attrs: nounwind
declare void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1ERKS3_(ptr noundef nonnull align 8 dereferenceable(32), ptr noundef nonnull align 1 dereferenceable(1)) unnamed_addr #2

declare void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE7reserveEm(ptr noundef nonnull align 8 dereferenceable(32), i64 noundef) #1

; Function Attrs: nounwind
declare noundef i64 @_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4sizeEv(ptr noundef nonnull align 8 dereferenceable(32)) #2

declare noundef nonnull align 8 dereferenceable(32) ptr @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE6appendEPKcm(ptr noundef nonnull align 8 dereferenceable(32), ptr noundef, i64 noundef) #1

declare noundef nonnull align 8 dereferenceable(32) ptr @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE6appendERKS4_(ptr noundef nonnull align 8 dereferenceable(32), ptr noundef nonnull align 8 dereferenceable(32)) #1

; Function Attrs: nounwind
declare i64 @strlen(ptr noundef) #2

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZNSt16allocator_traitsISaIcEE37select_on_container_copy_constructionERKS0_(ptr noalias sret(%"class.std::allocator") align 1 %0, ptr noundef nonnull align 1 dereferenceable(1) %1) #6 comdat align 2 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %4, align 8
  call void @_ZNSaIcEC1ERKS_(ptr noundef nonnull align 1 dereferenceable(1) %0, ptr noundef nonnull align 1 dereferenceable(1) %5) #3
  ret void
}

; Function Attrs: nounwind
declare void @_ZNSaIcEC1ERKS_(ptr noundef nonnull align 1 dereferenceable(1), ptr noundef nonnull align 1 dereferenceable(1)) unnamed_addr #2

declare noundef nonnull align 8 dereferenceable(32) ptr @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE6appendEPKc(ptr noundef nonnull align 8 dereferenceable(32), ptr noundef) #1

; Function Attrs: nounwind
declare void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1EOS4_(ptr noundef nonnull align 8 dereferenceable(32), ptr noundef nonnull align 8 dereferenceable(32)) unnamed_addr #2

; Function Attrs: noinline uwtable
define internal void @_GLOBAL__sub_I_main.cxx() #0 section ".text.startup" {
  call void @__cxx_global_var_init()
  ret void
}

attributes #0 = { noinline uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind }
attributes #4 = { mustprogress noinline optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nounwind allocsize(0) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { mustprogress noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #7 = { noreturn nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #8 = { mustprogress noinline norecurse optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #9 = { nocallback nofree nosync nounwind willreturn }
attributes #10 = { noinline optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #11 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #12 = { noinline noreturn nounwind }
attributes #13 = { nounwind allocsize(0) }
attributes #14 = { noreturn nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 15.0.7"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
