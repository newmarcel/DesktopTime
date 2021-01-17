//
//  DTIDefines.h
//  DesktopTime
//
//  Created by Marcel Dierkes on 17.01.21.
//

#ifndef DTI_DEFINES_H
#define DTI_DEFINES_H

#define Auto const __auto_type
#define AutoVar __auto_type
#define AutoWeak __weak __auto_type

#if DEBUG
#define DTILog(_args...) NSLog(_args)
#else
#define DTILog(_args...)
#endif

#endif /* DTI_DEFINES_H */
