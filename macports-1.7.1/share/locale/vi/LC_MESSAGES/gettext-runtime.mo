��    *      l  ;   �      �  B   �  !  �  �    9   �  M   9     �     �  ,   �     �  %   	  ,   ,	  -   Y	      �	  &   �	     �	     �	     
  �   
  e     :   z    �  �  �  �  �     A     V  *   g  1   �  &   �     �     �  "     9   2  I   l  �   �     T     d     }     �     �     �     �  �  �  L   �  k  �    G  E   c  R   �  -   �  .   *  8   Y  &   �  2   �  8   �  9   %  )   _  5   �  0   �  0   �     !  E  .  �   t  Z     �  ]  �  �    �"     �$     �$  6   �$  3   %  9   Q%     �%     �%  A   �%  W   �%  g   R&  �   �&     �'     �'     �'     �'     (     /(  	   H(           "      '                          %                                                      #      &              $   )           	            (   !          *             
                               -V, --version               output version information and exit
   -d, --domain=TEXTDOMAIN   retrieve translated message from TEXTDOMAIN
  -e                        enable expansion of some escape sequences
  -E                        (ignored for compatibility)
  -h, --help                display this help and exit
  -V, --version             display version information and exit
  [TEXTDOMAIN]              retrieve translated message from TEXTDOMAIN
  MSGID MSGID-PLURAL        translate MSGID (singular) / MSGID-PLURAL (plural)
  COUNT                     choose singular/plural form based on this value
   -d, --domain=TEXTDOMAIN   retrieve translated messages from TEXTDOMAIN
  -e                        enable expansion of some escape sequences
  -E                        (ignored for compatibility)
  -h, --help                display this help and exit
  -n                        suppress trailing newline
  -V, --version             display version information and exit
  [TEXTDOMAIN] MSGID        retrieve translated message corresponding
                            to MSGID from TEXTDOMAIN
   -h, --help                  display this help and exit
   -v, --variables             output the variables occurring in SHELL-FORMAT
 %s: illegal option -- %c
 %s: invalid option -- %c
 %s: option `%c%s' doesn't allow an argument
 %s: option `%s' is ambiguous
 %s: option `%s' requires an argument
 %s: option `--%s' doesn't allow an argument
 %s: option `-W %s' doesn't allow an argument
 %s: option `-W %s' is ambiguous
 %s: option requires an argument -- %c
 %s: unrecognized option `%c%s'
 %s: unrecognized option `--%s'
 Bruno Haible Copyright (C) %s Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
 Display native language translation of a textual message whose grammatical
form depends on a number.
 Display native language translation of a textual message.
 If the TEXTDOMAIN parameter is not given, the domain is determined from the
environment variable TEXTDOMAIN.  If the message catalog is not found in the
regular directory, another location can be specified with the environment
variable TEXTDOMAINDIR.
Standard search directory: %s
 If the TEXTDOMAIN parameter is not given, the domain is determined from the
environment variable TEXTDOMAIN.  If the message catalog is not found in the
regular directory, another location can be specified with the environment
variable TEXTDOMAINDIR.
When used with the -s option the program behaves like the `echo' command.
But it does not simply copy its arguments to stdout.  Instead those messages
found in the selected catalog are translated.
Standard search directory: %s
 In normal operation mode, standard input is copied to standard output,
with references to environment variables of the form $VARIABLE or ${VARIABLE}
being replaced with the corresponding values.  If a SHELL-FORMAT is given,
only those environment variables that are referenced in SHELL-FORMAT are
substituted; otherwise all environment variables references occurring in
standard input are substituted.
 Informative output:
 Operation mode:
 Report bugs to <bug-gnu-gettext@gnu.org>.
 Substitutes the values of environment variables.
 Try `%s --help' for more information.
 Ulrich Drepper Unknown system error Usage: %s [OPTION] [SHELL-FORMAT]
 Usage: %s [OPTION] [TEXTDOMAIN] MSGID MSGID-PLURAL COUNT
 Usage: %s [OPTION] [[TEXTDOMAIN] MSGID]
or:    %s [OPTION] -s [MSGID]...
 When --variables is used, standard input is ignored, and the output consists
of the environment variables that are referenced in SHELL-FORMAT, one per line.
 Written by %s.
 error while reading "%s" memory exhausted missing arguments standard input too many arguments write error Project-Id-Version: gettext-runtime 0.16.2-pre5
Report-Msgid-Bugs-To: bug-gnu-gettext@gnu.org
POT-Creation-Date: 2007-11-02 03:22+0100
PO-Revision-Date: 2007-10-17 16:23+0930
Last-Translator: Clytie Siddall <clytie@riverland.net.au>
Language-Team: Vietnamese <vi-VN@googlegroups.com> 
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Plural-Forms: nplurals=1; plural=0;
X-Generator: LocFactoryEditor 1.7b1
   -V, --version               xuất thông tin _phiên bản_ rồi thoát
   -d, --domain=MIỀN_VĂN_BẢN   lấy thông điệp đã dịch từ _miền_ này
  -e                        bật _mở rộng_ một số dãy thoát
  -E                        (bị bỏ qua để không tương thích)
  -h, --help          	hiện _trợ giúp_ này rồi thoát
  -V, --version     	hiện thông tin _phiên bản_ rồi thoát
  [MIỀN_VĂN_BẢN]    	lấy thông điệp đã dịch từ miền văn bản này
  MSGID MSGID-NHIỀU        dịch MSGID (số ít) / MSGID-NHIỀU (số nhiều)
  SỐ_ĐẾM            	chọn dạng số ít/số nhiều dựa vào giá trị này
   -d, --domain=MIỀN_VAN_BẢN   lấy các thông điệp đã dịch từ miền này
  -e                        bật mở rộng một số dãy thoát
  -E                        (bị bỏ qua để tương thích)
  -h, --help           	hiện _trợ giúp_ này rồi thoát
  -n                        thu hồi ký tự dòng _mới_ theo sau
  -V, --version     	hiện thông tin _phiên bản_ rồi thoát
  [MIỀN_VAN_BẢN] MSGID        lấy thông điệp đã dịch tương ứng với MSGID
	từ MIỀN_VAN_BẢN
   -h, --help                  hiện _trợ giúp_ này rồi thoát
  -v, --variables
	xuất những _biến_ xảy ra theo ĐỊNH DẠNG TRÌNH BAO
 %s: không cho phép tùy chọn « -- %c »
 %s: tùy chọn không hợp lệ « -- %c »
 %s: tùy chọn « %c%s » không cho phép đối số
 %s: tùy chọn « %s » là mơ hồ
 %s: tùy chọn « %s » cần đến đối số
 %s: tùy chọn « --%s » không cho phép đối số
 %s: tùy chọn « -W %s » không cho phép đối số
 %s: tùy chọn « -W %s » là mơ hồ
 %s: tùy chọn cần đến đối số « -- %c »
 %s: không nhận diện tùy chọn « %c%s »
 %s: không nhận diện tùy chọn « --%s »
 Bruno Haible Tác quyền © %s Tổ chức Phần mềm Tự do.
Giấy Phép Công Cộng GNU (GPL), phiên bản 3 hay sau <http://gnu.org/licenses/gpl.html>
Đây là phần mềm tự do : bạn có quyền thay đổi và phát hành lại nó.
KHÔNG CÓ BẢO HÀNH GÌ CẢ, với điều kiện được pháp luật cho phép.
 Hiển thị bản dịch ngôn ngữ mẹ đẻ của thông điệp thuộc văn bản có dạng
ngữ pháp phụ thuộc vào con số.
 Hiển thị bản dịch ngôn ngữ mẹ đẻ của thông điệp thuộc văn bản.
 Tham số MIỀN VĂN BẢN không đưa ra thì miền được quyết định
từ biến môi trường TEXTDOMAIN (miền văn bản). Nếu không tìm thấy
phân loại thông điệp trong thư mục bình thường, vị trí khác có thể được
xác định bằng biến môi trường TEXTDOMAINDIR (thư mục của miền văn bản).
Thư mục tìm kiếm chuẩn: %s
 Tham số MIỀN_VAN_BẢN không đưa ra thì miền được quyết định
từ biến môi trường TEXTDOMAIN (miền văn bản). Nếu không tìm thấy
phân loại thông điệp trong thư mục bình thường, vị trí khác có thể được
xác định bằng biến môi trường TEXTDOMAINDIR (thư mục của miền văn bản).
Khi dùng với tùy chọn « -s », chương trình này ứng xử giống như
lệnh « echo ». Nhưng mà nó không phải đơn giản sao chép các đối số của nó
sang thiết bị xuất chuẩn. Thay thế những thông điệp đã tìm trong phân loại
được chọn có được dịch.
Thư mục tìm kiếm chuẩn: %s
 Trong chế độ thao tác bình thường, thiết bị nhập chuẩn được sao chép
sang thiết bị xuất chuẩn; mỗi tham chiếu đến biến môi trường có dạng
$BIẾN hay ${BIẾN} được thay thế bằng giá trị tương ứng. ĐỊNH DẠNG
TRÌNH BAO đưa ra thì chỉ những biến môi trường đã tham chiếu trong
ĐỊNH DẠNG TRÌNH BAO được thay thế; không thì mọi tham chiếu biến
môi trường xảy ra trong thiết bị nhập chuẩn được thay thế.
 Kết xuất thông tin:
 Chế độ thao tác:
 Hãy thông báo lỗi cho <bug-gnu-gettext@gnu.org>.
 Thay thế giá trị của biến môi trường.
 Thử lệnh « %s --help » để xem thông tin thêm.
 Ulrich Drepper Lỗi hệ thống không rõ Cách sử dụng: %s [TÙY_CHỌN] [ĐỊNH_DẠNG_TRÌNH_BAO)]
 Cách sử dụng: %s [TÙY_CHỌN] [MIỀN_VAN_BẢN] MSGID MSGID-NHIỀU SỐ_ĐẾM
 Cách sử dụng: %s [TÙY_CHỌN] [[MIỀN_VĂN_BẢN] MSGID]
hay:    %s [TÙY_CHỌN] -s [MSGID]...
 Khi tùy chọn « --variables » (biến) được dùng, thiết bị nhập chuẩn bị bỏ qua,
và kết xuất gồm có những biến môi trường được tham chiếu trong ĐỊNH DẠNG
TRÌNH BAO, một điều trên mỗi dòng.
 Tác giả: %s.
 gặp lỗi khi đọc « %s » hết bộ nhớ rồi đối số còn thiếu thiết bị nhập chuẩn quá nhiều đối số lỗi ghi 