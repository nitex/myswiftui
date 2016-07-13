#!/usr/local/bin/perl
#########################################
#     Copyright    WM   1998            #
#     Все права зашищены(1998).         #
#     Гостевая книга                    #
#     По всем вопросам - Миша           #
#     email: scorp@i-connect.ru         #
#     url: http://wmcgi.hypermart.net   #
#########################################
# Установка переменных
$local_book = "/data1/hypermart.net/wmcgi/guestbook/guestbook.html"; # страница гостевой книги на сервере
$inet_book = "http://wmcgi.hypermart.net/guestbook/guestbook.html"; # в интернете
$cgi = "http://wmcgi.hypermart.net/guestbook/guest.cgi"; # скрипт гостевой книги
$base = "http://wmcgi.hypemart.net/guestbook/"; # где находятся файлы
$up = 1; #вверху новая запись (1) или внизу (0)
$date_command = "/bin/date"; #команда даты



############################################################
$date = `$date_command +"%B %d, %Y"`; chop($date);

read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});
@pairs = split(/&/, $buffer);
foreach $pair (@pairs) {
   ($name, $value) = split(/=/, $pair);
   $value =~ tr/+/ /;
   $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
   $value =~ s/<!--(.|\n)*-->//g;
   $value =~ s/<([^>]|\n)*>//g;
   $FORM{$name} = $value;
}

########
&error_comments unless $FORM{'comments'};
&error_name unless $FORM{'name'};
&error_email unless $FORM{'email'};

########
if (&verify_email($FORM{'email'})) {
}
else {
&error_email;
}

########
open (FILE,"$local_book") || die "Can't Open $local_book: $!\n";
@LINES=<FILE>;
close(FILE);
$SIZE=@LINES;

open (GUEST,">$local_book") || die "Can't Open $local_book: $!\n";

for ($i=0;$i<=$SIZE;$i++) {
   $_=$LINES[$i];
   if (/<!--add-->/) { 
      if ($up eq '1') {
         print GUEST "<!--add-->\n";
      }
      if ( $FORM{'name'}) {
         print GUEST "$FORM{'name'} - $date<br>\n";
         }
      if ($FORM{'email'}) {
         print GUEST "<B>E-mail:</B><A HREF=\"mailto:$FORM{'email'}\"> $FORM{'email'}</A><br>\n";
      }
      if ($FORM{'url'} ne "http://") {
         print GUEST "<B>URL:</B><A HREF=$FORM{'url'}>$FORM{'url'}</A><br>\n";
      }
      else {
      }
      if ( $FORM{'city'} ){
         print GUEST "<B>Местожительство: </B>$FORM{'city'}";
         print GUEST ", &nbsp;&nbsp;&nbsp;&nbsp; $FORM{'country'}<br>\n";
      }
      print GUEST "<B>Комментарии:&nbsp;&nbsp;</B><br> \n";
      print GUEST "$FORM{'comments'}<br><hr>\n";
      print GUEST "\n\n\n";
      if ($up eq '0') {
         print GUEST "<!--add->\n";
      }
   }
   else {
      print GUEST $_;
   }
}
close (GUEST);
##############
# Запись добавлена
   print "Content-Type: text/html\n\n";
   print "<html><head><title>Спасибо за запись в гостевой книге</title></head>\n";
   print "<body>\n";
   open (HEAD, "header.txt");

	@head = <HEAD>;
	close (HEAD);
			foreach $line (@head) {
			print "$line\n";
		}
   print "Спасибо . Ваши комментарии были добавленны в "; 
   print "<A HREF=\"$inet_book\">гостевую книгу.</A><P>\n";
   print "Ваши данные:<P>\n";
      if ( $FORM{'name'}) {
         print "<B>Имя:</B> $FORM{'name'} - $date<BR>\n";
         }
      if ($FORM{'email'}) {
         print "<B>E-mail:</B> <a href=\"mailto:$FORM{'email'}\"> $FORM{'email'}</a><BR>\n";
      }
      if ($FORM{'url'} ne "http://") {
      print "<B>URL:</B> <a href=$FORM{'url'}>$FORM{'url'}</a><BR>\n";
      }
      else {
      }
      if ( $FORM{'city'} ){
         print "<B>Местожительство: </B>$FORM{'city'}";
         print ",&nbsp;&nbsp;&nbsp;&nbsp; $FORM{'country'}<BR>";
      }
      print "<BR><BR><B>Комментарии:</B>\n";
      print "$FORM{'comments'}<BR>\n";
      	 open (FOOT, "footer.txt");

	@foot = <FOOT>;
	close (FOOT);
			foreach $line (@foot) {
			print "$line\n";
		}	
      print "</body></html>\n";
      exit;


#######################
# Ошибки
sub error_name {
   print "Content-type: text/html\n\n";
 print "<html><head><title>Вы не вписали ваше имя</title></head>\n";
   print "<body>\n";
   open (HEAD, "header.txt");

	@head = <HEAD>;
	close (HEAD);
			foreach $line (@head) {
			print "$line\n";
		}
   print "Вы забыли написать Ваше Имя\n";
   print "Пожалуйста заполните форму еще раз.<p>\n";
   print "<TABLE  CELLSPACING=3 CELLPADDING=2>\n";
   print "<FORM METHOD=POST ACTION=\"$cgi\">\n";
   print "<TR><TD><B>Имя:</B></TD><TD><INPUT TYPE=TEXT NAME=\"name\" "; 
   print "SIZE=50></TD></TR>\n";
   print "<TR><TD><B>E-Mail:</B></TD><TD><INPUT TYPE=TEXT NAME=\"email\" "; 
   print "VALUE=\"$FORM{'email'}\" SIZE=50></TD></TR>\n";
   print "<TR><TD><B>URL:</B></TD><TD><INPUT TYPE=TEXT NAME=\"url\" "; 
   print "VALUE=\"$FORM{'url'}\" SIZE=50></TD></TR>\n";
   print "<TR><TD><B>Город:</B></TD><TD><INPUT TYPE=TEXT NAME=\"city\" ";
   print "VALUE=\"$FORM{'city'}\" SIZE=15>\n";
   print "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ";
     print "<B>Страна:</B> ";
   print "<INPUT TYPE=TEXT NAME=\"country\" VALUE=\"$FORM{'country'}\" SIZE=10></TR>\n";
   print "<TR><TD><B>Комментарии:</B></TD><TD>";
   print "<INPUT TYPE=HIDDEN NAME=\"comments\" "; 
   print "VALUE=\"$FORM{'comments'}\"></TD></TR>\n";
   print "<TR><TD>&nbsp;&nbsp;</TD><TD></TD></TR>\n";
   print "<TR><TD></TD><TD><INPUT TYPE=submit></TD></TR>\n";
   print "</TABLE>\n";
   print "</FORM>\n";
	 open (FOOT, "footer.txt");

	@foot = <FOOT>;
	close (FOOT);
			foreach $line (@foot) {
			print "$line\n";
		}	
   print "</BODY></HTML>\n";   
   exit;
}

sub error_email {
   print "Content-type: text/html\n\n";
 print "<html><head><title>Вы не вписали ваш e-mail</title></head>\n";
   print "<body>\n";
   open (HEAD, "header.txt");

	@head = <HEAD>;
	close (HEAD);
			foreach $line (@head) {
			print "$line\n";
		}
   print "Вы забыли ввести свой e-mail\n";
   print "Пожалуйста заполните форму еще раз.<p>\n";
   print "<TABLE  CELLSPACING=3 CELLPADDING=2>\n";
   print "<FORM METHOD=POST ACTION=\"$cgi\">\n";
   print "<TR><TD><B>Имя:</B></TD><TD><INPUT TYPE=TEXT NAME=\"name\" VALUE=\"$FORM{'name'}\" "; 
   print "SIZE=50></TD></TR>\n";
   print "<TR><TD><B>E-Mail:</B></TD><TD><INPUT TYPE=TEXT NAME=\"email\" "; 
   print "VALUE=\"$FORM{'email'}\" SIZE=50></TD></TR>\n";
   print "<TR><TD><B>URL:</B></TD><TD><INPUT TYPE=TEXT NAME=\"url\" "; 
   print "VALUE=\"$FORM{'url'}\" SIZE=50></TD></TR>\n";
   print "<TR><TD><B>Город:</B></TD><TD><INPUT TYPE=TEXT NAME=\"city\" ";
   print "VALUE=\"$FORM{'city'}\" SIZE=15>\n";
   print "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ";
   print "<B>Страна:</B> ";
   print "<INPUT TYPE=TEXT NAME=\"country\" VALUE=\"$FORM{'country'}\" SIZE=10></TR>\n";
   print "<TR><TD><B>Комментарии:</B></TD><TD>";
   print "<INPUT TYPE=HIDDEN NAME=\"comments\" "; 
   print "VALUE=\"$FORM{'comments'}\"></TD></TR>\n";
   print "<TR><TD>&nbsp;&nbsp;</TD><TD></TD></TR>\n";
   print "<TR><TD></TD><TD><INPUT TYPE=submit></TD></TR>\n";
   print "</TABLE>\n";
   print "</FORM>\n";
	 open (FOOT, "footer.txt");

	@foot = <FOOT>;
	close (FOOT);
			foreach $line (@foot) {
			print "$line\n";
		}	
   print "</BODY></HTML>\n";   
   exit;
}

sub error_comments {
   print "Content-type: text/html\n\n";
  print "<html><head><title>Вы не ввели комментарии</title></head>\n";
   print "<body>\n";
   open (HEAD, "header.txt");

	@head = <HEAD>;
	close (HEAD);
			foreach $line (@head) {
			print "$line\n";
		}
   print "<CENTER><IMG SRC=\"$base$gif2\"></CENTER><BR>\n";
   print "Вы забыли написать комментарии\n";
   print "Пожалуйста заполните форму еще раз.<p>\n";
   print "<TABLE CELLSPACING=3 CELLPADDING=2>\n";
   print "<FORM METHOD=POST ACTION=\"$cgi\">\n";
   print "<TR><TD><B>Имя:</B></TD><TD><INPUT TYPE=TEXT NAME=\"name\" ";
   print "VALUE=\"$FORM{'name'}\" SIZE=50></TD></TR>\n";
   print "<TR><TD><B>E-Mail:</B></TD><TD><INPUT TYPE=TEXT NAME=\"email\" ";
   print "VALUE=\"$FORM{'email'}\" SIZE=50></TD></TR>\n";
   print "<TR><TD><B>URL:</B></TD><TD><INPUT TYPE=TEXT NAME=\"url\" ";
   print "VALUE=\"$FORM{'url'}\" SIZE=50></TD></TR>\n";
   print "<TR><TD><B>Город:</B></TD><TD><INPUT TYPE=TEXT NAME=\"city\" "; 
   print "VALUE=\"$FORM{'city'}\" SIZE=15>\n";
   print "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<B>Страна:</B> ";
   print "<INPUT TYPE=TEXT NAME=\"country\" VALUE=\"$FORM{'country'}\" SIZE=10></TR>\n";
   print "<TR><TD><B>Комментарии:</B></TD><TD><TEXTAREA NAME=\"comments\" "; 
   print "COLS=50 ROWS=7></TEXTAREA><p>\n";
   print "<TR><TD>&nbsp;&nbsp;</TD><TD></TD></TR>\n";
   print "<TR><TD></TD><TD><INPUT TYPE=submit></TD></TR>\n";
   print "</TABLE>\n";
   print "</FORM>\n";
	 open (FOOT, "footer.txt");

	@foot = <FOOT>;
	close (FOOT);
			foreach $line (@foot) {
			print "$line\n";
		}	
   print "\n</BODY></HTML>\n";   
   exit;
}

sub verify_email {
    local($emails) = $_[0];

    if ($emails =~ /(@.*@)|(\.\.)|(@\.)|(\.@)|(^\.)|(\.$)/ || 
        ($emails !~ /^.+\@localhost$/ && 
         $emails !~ /^.+\@\[?(\w|[-.])+\.[a-zA-Z]{2,3}|[0-9]{1,3}\]?$/)) {
        return(0);
    }
    
    else {
        return(1);
    }
}
1;