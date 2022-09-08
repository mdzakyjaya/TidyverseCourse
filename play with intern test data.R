# PHONE NUMBER

#import data
dt <- readxl::read_xlsx("D:/tes.xlsx", sheet = 2)

# replace strip sign and blank spaces
dt$`phone number` <- str_replace_all(dt$`phone number`, " |-", "")

# replace +62 or (+62) at the beginning with 0
dt$`phone number` <- str_replace(dt$`phone number`, "^\\+62|\\(\\+62\\)", "0")

# add leading zero to all phone number records that doesn't have leading zeros
str_sub(dt[str_detect(dt$`phone number`, "^[^0]"), ], 0, 0) <- 0

dt

# Another WOW way to clean phone number column

#import data
dt <- readxl::read_xlsx("D:/tes.xlsx", sheet = 2)

# replace strip sign and blank spaces
dt$`phone number` <- str_replace_all(dt$`phone number`, " |-", "")

dt <- dt %>% mutate(`phone number` = case_when(
        str_detect(`phone number`, "^8") ~ str_c("62", `phone number`, sep = ""),
        str_detect(`phone number`, "^0") ~ str_replace(`phone number`, "^0", "62"),
        str_detect(`phone number`, "^\\+") ~ str_remove(`phone number`, "^\\+"),
        str_detect(`phone number`, "^\\(") ~ str_remove_all(`phone number`, "\\(|\\+|\\)")
        )) %>% mutate(`phone number` =  case_when(
                str_detect(`phone number`, "^62[^8]") ~ str_replace(`phone number`, "^62", "628"),
                T ~ `phone number`
                ))

dt
