package game.data.locale
{
   import com.progrestar.common.lang.LocaleEN;
   import com.progrestar.common.lang.LocaleEnum;
   import com.progrestar.common.lang.LocaleRU;
   import com.progrestar.common.lang.Translate;
   
   public final class LocaleStorage
   {
       
      
      private var _localeId:String;
      
      public function LocaleStorage(param1:Object, param2:String)
      {
         super();
         this._localeId = param2;
         if(_localeId == LocaleEnum.RUSSIAN.id)
         {
            Translate.init(new LocaleRU());
         }
         else
         {
            Translate.init(new LocaleEN());
         }
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for(var _loc3_ in param1)
         {
            Translate.prepare(_loc3_,param1[_loc3_]);
         }
      }
      
      public function get localeId() : String
      {
         return _localeId;
      }
   }
}
