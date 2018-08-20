package engine.context.platform.social
{
   public class OKSocialFacadeHelper
   {
      
      public static var _promo_active:Boolean;
      
      public static var _showPortalPaymentBox_func:Function;
      
      public static var session_key:String;
      
      public static var session_secret_key:String;
      
      public static var _agdvf_id:String;
       
      
      public function OKSocialFacadeHelper(param1:Object)
      {
         super();
         session_secret_key = param1.session_secret_key;
         session_key = param1.session_key;
      }
      
      public static function showPortalPaymentBox() : void
      {
         if(_showPortalPaymentBox_func)
         {
            _showPortalPaymentBox_func();
         }
      }
      
      public static function get promo_active() : Boolean
      {
         return _promo_active;
      }
   }
}
