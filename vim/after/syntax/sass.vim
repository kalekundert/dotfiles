" Recognize abstract classes (%).
syn match sassClassChar  "[.%][[:alnum:]_-]\@=" nextgroup=sassClass

highlight link sassClass Identifier
