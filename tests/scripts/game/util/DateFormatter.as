package game.util
{
   import flash.globalization.DateTimeFormatter;
   
   public class DateFormatter
   {
      
      private static var _dateTimeFormatterHHMM:DateTimeFormatter;
      
      private static var localeIdDefault:String = "i-default";
      
      private static var _dateTimeFormatterHHMMSS:DateTimeFormatter;
      
      private static var _dateTimeFormatter:DateTimeFormatter;
      
      private static var _dateTimeFormatterDDMMYYYY_HHMMSS:DateTimeFormatter;
       
      
      public function DateFormatter()
      {
         super();
      }
      
      private static function get dateTimeFormatterHHMM() : DateTimeFormatter
      {
         if(_dateTimeFormatterHHMM == null)
         {
            _dateTimeFormatterHHMM = new DateTimeFormatter(localeIdDefault);
            _dateTimeFormatterHHMM.setDateTimePattern("HH:mm");
         }
         return _dateTimeFormatterHHMM;
      }
      
      private static function get dateTimeFormatterHHMMSS() : DateTimeFormatter
      {
         if(_dateTimeFormatterHHMMSS == null)
         {
            _dateTimeFormatterHHMMSS = new DateTimeFormatter(localeIdDefault);
            _dateTimeFormatterHHMMSS.setDateTimePattern("HH:mm:ss");
         }
         return _dateTimeFormatterHHMMSS;
      }
      
      private static function get dateTimeFormatter() : DateTimeFormatter
      {
         if(_dateTimeFormatter == null)
         {
            _dateTimeFormatter = new DateTimeFormatter(localeIdDefault);
            _dateTimeFormatter.setDateTimeStyles("short","none");
            _dateTimeFormatter.setDateTimePattern("DD-MM-YYYY");
         }
         return _dateTimeFormatter;
      }
      
      private static function get dateTimeFormatterDDMMYYYY_HHMMSS() : DateTimeFormatter
      {
         if(_dateTimeFormatterDDMMYYYY_HHMMSS == null)
         {
            _dateTimeFormatterDDMMYYYY_HHMMSS = new DateTimeFormatter(localeIdDefault);
            _dateTimeFormatterDDMMYYYY_HHMMSS.setDateTimeStyles("short","medium");
            _dateTimeFormatterDDMMYYYY_HHMMSS.setDateTimePattern("DD-MM-YYYY HH:mm:ss");
         }
         return _dateTimeFormatterDDMMYYYY_HHMMSS;
      }
      
      public static function HHMM(param1:Number) : String
      {
         return dateToHHMM(new Date(param1 * 1000));
      }
      
      public static function dateToHHMM(param1:Date) : String
      {
         return dateTimeFormatterHHMM.format(param1).replace(".","/").replace(".","/");
      }
      
      public static function HHMMSS(param1:Number) : String
      {
         return dateToHHMMSS(new Date(param1 * 1000));
      }
      
      public static function dateToHHMMSS(param1:Date) : String
      {
         return dateTimeFormatterHHMMSS.format(param1).replace(".","/").replace(".","/");
      }
      
      public static function DDMMYYYY(param1:Number) : String
      {
         return dateToDDMMYYYY(new Date(param1 * 1000));
      }
      
      public static function dateToDDMMYYYY(param1:Date) : String
      {
         return dateTimeFormatter.format(param1).replace(".","/").replace(".","/");
      }
      
      public static function dateToDDMMYYYY_HHMMSS(param1:Date) : String
      {
         return dateTimeFormatterDDMMYYYY_HHMMSS.format(param1);
      }
   }
}
