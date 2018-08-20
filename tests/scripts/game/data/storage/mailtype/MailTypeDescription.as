package game.data.storage.mailtype
{
   import game.data.storage.DescriptionBase;
   
   public class MailTypeDescription extends DescriptionBase
   {
      
      public static const MASS_IMPORTANT:String = "massImportant";
      
      public static const MASS:String = "mass";
      
      public static const REGISTRATION_GIFT:String = "registrationGift";
      
      public static const ARENA_DAILY_TOP:String = "top";
      
      public static const PROMOTE_GIFT:String = "promoteGift";
       
      
      public var type:String;
      
      public var alttype:String;
      
      public var massFarmEnabled:Boolean;
      
      public function MailTypeDescription(param1:Object)
      {
         super();
         _id = param1.id;
         type = param1.type;
         alttype = param1.alttype;
         massFarmEnabled = param1.massFarmEnabled;
      }
   }
}
