package game.view.popup.activity.customtab
{
   import game.view.popup.activity.CustomSpecialQuestEventChainTabValueObject;
   import game.view.popup.activity.ISpecialQuestEventCustomTab;
   import game.view.popup.activity.SpecialQuestEventChainTabValueObject;
   import game.view.popup.activity.customtab.pairofdeers.PairOfDeersSpecialQuestEventCustomTab;
   
   public class SpecialOfferCustomTabs
   {
       
      
      public function SpecialOfferCustomTabs()
      {
         super();
      }
      
      public static function addCustomTabs(param1:Vector.<SpecialQuestEventChainTabValueObject>, param2:int) : void
      {
         var _loc3_:* = null;
         if(!(int(param2) - 21))
         {
            _loc3_ = new PairOfDeersSpecialQuestEventCustomTab();
            param1.unshift(new CustomSpecialQuestEventChainTabValueObject(_loc3_));
         }
      }
   }
}
