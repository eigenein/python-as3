package engine.context.platform.social
{
   public class FBSocialFacadeHelper
   {
      
      public static var fbPaymentMobilePricePoints:Object;
      
      public static var fbPaymentPricePoints:Object;
      
      public static var fbPromoEnabled:Boolean;
      
      public static var fbCurrency:Object;
      
      public static var fbCurrencyURL:String;
      
      public static var countryCode:String;
      
      public static var tpClickId:String;
      
      public static var tpTypeId:String;
      
      public static var tpTimeLimit:String;
      
      public static var gameUrl:String;
      
      public static var fbDefaultInviteParams:Object;
      
      public static var email:String;
      
      public static var refID:String;
       
      
      public function FBSocialFacadeHelper(param1:Object)
      {
         super();
         tpClickId = param1.tpClickId;
         tpTypeId = param1.tpTypeId;
         tpTimeLimit = param1.tpTimeLimit;
      }
   }
}
