# Standard things
sp := $(sp).x
dirstack_$(sp) := $(d)
d := $(dir)
BUILDDIRS += $(BUILD_PATH)/$(d)
#BUILDDIRS += $(BUILD_PATH)/$(d)/utility

# Local flags
CXXFLAGS_$(d) := $(WIRISH_INCLUDES) $(LIBMAPLE_INCLUDES) -I$(d)/utility
CFLAGS_$(d) := $(WIRISH_INCLUDES) $(LIBMAPLE_INCLUDES) -I$(d)/utility


# Local rules and targets
cSRCS_$(d) :=  
cppSRCS_$(d) := \
				SX1278_Base.cpp \
                SX1278.cpp
#
cFILES_$(d) := $(cSRCS_$(d):%=$(d)/%)
cppFILES_$(d) := $(cppSRCS_$(d):%=$(d)/%)

OBJS_$(d) := $(cFILES_$(d):%.c=$(BUILD_PATH)/%.o) \
             $(cppFILES_$(d):%.cpp=$(BUILD_PATH)/%.o)
DEPS_$(d) := $(OBJS_$(d):%.o=%.d)

$(OBJS_$(d)): TGT_CXXFLAGS := $(CXXFLAGS_$(d))
$(OBJS_$(d)): TGT_CFLAGS := $(CFLAGS_$(d))

TGT_BIN += $(OBJS_$(d))

# Standard things
-include $(DEPS_$(d))
d := $(dirstack_$(sp))
sp := $(basename $(sp))
