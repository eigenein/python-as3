package game.data.storage.notification
{
   import game.data.storage.DescriptionBase;
   
   public class NotificationDescription extends DescriptionBase
   {
      
      public static const FRIEND_GIFT:String = "friendGift";
      
      public static const NY2018_GIFT:String = "newYear2018Gift";
       
      
      private var _ident:String;
      
      private var _type:NotificationType;
      
      private var _translationIdent:String;
      
      public function NotificationDescription(param1:Object)
      {
         super();
         _ident = param1.ident;
         _type = param1.type == "a2u"?NotificationType.A2U:NotificationType.U2U;
         _translationIdent = "LIB_NOTIFICATION_" + ident.toUpperCase();
      }
      
      public function get ident() : String
      {
         return _ident;
      }
      
      public function get type() : NotificationType
      {
         return _type;
      }
      
      public function get translationIdent() : String
      {
         return _translationIdent;
      }
   }
}
