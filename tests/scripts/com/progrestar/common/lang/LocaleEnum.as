package com.progrestar.common.lang
{
   public class LocaleEnum
   {
      
      public static const RUSSIAN:Locale = new LocaleRU();
      
      public static const ENGLISH:Locale = new LocaleEN();
      
      public static const FRENCH:Locale = new LocaleFR();
      
      public static const GERMAN:Locale = new LocaleDE();
      
      public static const ITALIAN:Locale = new LocaleIT();
      
      public static const PORTUGUESE:Locale = new Locale("pt");
      
      public static const SPANISH:Locale = new LocaleES();
      
      public static const JAPANESE:Locale = new Locale("ja");
      
      public static const KOREAN:Locale = new Locale("ko");
      
      public static const CHINESE:Locale = new Locale("zh");
      
      public static const CHINESE_TW:Locale = new Locale("zh-tw");
      
      public static const CHINESE_CN:Locale = new Locale("zh-cn");
      
      static const ASIAN_LANGUAGES:Vector.<Locale> = new <Locale>[CHINESE,CHINESE_TW,CHINESE_CN,KOREAN,JAPANESE];
       
      
      public function LocaleEnum()
      {
         super();
      }
   }
}
