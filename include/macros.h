#ifndef MACROS_H
#define MACROS_H

#define STR_(x)					#x
#define STR(x)					STR_(x)

#define CONCAT5_(a, b, c, d, e)	a ## b ## c ## d ## e
#define CONCAT5(a, b, c, d, e)	CONCAT5_(a, b, c, d, e)

// warning: double side effects may occur
#define MAX(x, y)					((x) > (y) ? (x) : (y))
#define MIN(x, y)					((x) < (y) ? (x) : (y))

#define CLAMP(x, low, high)	\
	((x) < (low) ? (low) : ((x) > (high) ? (high) : (x)))

#define ROUND_UP(x, align)			(((x) + ((align) - 1)) & -(align))
#define ROUND_UP_PTR(x, align)	\
	(void *)((((xu32)(x)) + (align) - 1) & -(align))

#define ROUND_DOWN(x, align)		((x) & -(align))
#define ROUND_DOWN_PTR(x, align)	(void *)(((xu32)(x)) & -(align))

#define ARRAY_LENGTH(x)			(sizeof (x) / sizeof ((x)[0]))

#if !defined(NDEBUG)
# define RVLB_INFIX_			DEBUG
# define RVLB_STRING_			"debug"
#else
# define RVLB_INFIX_			RELEASE
# define RVLB_STRING_			"release"
#endif

#define CW_VERSION				STR(__CWCC__) "_" STR(__CWBUILD__)

#define REVOLUTION_LIB_VERSION_STRING(main_lib_, lib_, build_type_, date_, time_)	\
	"<< " main_lib_ " - " lib_ " \t" build_type_ " build: " date_ " " time_ " (" CW_VERSION ") >>"

#define RVL_SDK_LIB_VERSION_STRING(lib_)	\
	REVOLUTION_LIB_VERSION_STRING("RVL_SDK", #lib_, RVLB_STRING_,	\
		CONCAT5(RVL_SDK_, lib_, _, RVLB_INFIX_, _BUILD_DATE),		\
		CONCAT5(RVL_SDK_, lib_, _, RVLB_INFIX_, _BUILD_TIME))

#endif // MACROS_H
