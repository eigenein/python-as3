package game.view.popup.activity
{
   import com.progrestar.common.lang.Translate;
   import game.model.user.Player;
   
   public class QuestEventDailyBonusValueObject extends QuestEventValueObjectBase
   {
       
      
      private var _dailyBonus:DailyBonusMediator;
      
      public function QuestEventDailyBonusValueObject(param1:Player)
      {
         super(param1);
         _dailyBonus = new DailyBonusMediator(param1);
         _dailyBonus.signal_update.add(handler_update);
         param1.signal_update.vip_level.add(handler_update);
         handler_update();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _dailyBonus.dispose();
         player.signal_update.vip_level.remove(handler_update);
      }
      
      override public function get hasEndTime() : Boolean
      {
         return false;
      }
      
      override public function get endTime() : Number
      {
         return 0;
      }
      
      override public function get name() : String
      {
         return Translate.translate("UI_DIALOG_DAILY_BONUS_TITLE");
      }
      
      override public function get desc() : String
      {
         return "";
      }
      
      override public function get iconAsset() : String
      {
         return "event_icon_000";
      }
      
      override public function get backgroundAsset() : String
      {
         return "event_background_000.jpg";
      }
      
      override public function get sortOrder() : int
      {
         return 0;
      }
      
      override public function get canFarmSortIgnore() : Boolean
      {
         return true;
      }
      
      public function get dailyBonus() : DailyBonusMediator
      {
         return _dailyBonus;
      }
      
      private function handler_update() : void
      {
         _canFarm.value = _dailyBonus.canFarm;
      }
   }
}
