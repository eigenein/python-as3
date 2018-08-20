package game.view.popup.activity
{
   import com.progrestar.common.lang.Translate;
   import feathers.core.PopUpManager;
   import game.command.rpc.dailybonus.CommandDailyBonusFarm;
   import game.data.storage.DataStorage;
   import game.data.storage.dailybonus.DailyBonusDescription;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.dailybonus.DailyBonusValueObject;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.stat.Stash;
   import game.view.popup.MessagePopup;
   import game.view.popup.dailybonus.DailyBonusPopupVipNeeded;
   import game.view.popup.dailybonus.DailyBonusRewardPopup;
   import org.osflash.signals.Signal;
   
   public class DailyBonusMediator
   {
       
      
      private var player:Player;
      
      private var items:Vector.<DailyBonusValueObject>;
      
      private var stashParams:PopupStashEventParams;
      
      public const signal_update:Signal = new Signal();
      
      public function DailyBonusMediator(param1:Player)
      {
         var _loc3_:* = null;
         items = new Vector.<DailyBonusValueObject>();
         super();
         this.player = param1;
         param1.dailyBonus.signal_update.add(handler_playerBonusUpdate);
         var _loc4_:Vector.<DailyBonusDescription> = param1.dailyBonus.getDescriptionVector();
         var _loc6_:int = 0;
         var _loc5_:* = _loc4_;
         for each(var _loc2_ in _loc4_)
         {
            _loc3_ = new DailyBonusValueObject(_loc2_);
            items.push(_loc3_);
            updateValueObject(_loc3_,false);
         }
      }
      
      public function dispose() : void
      {
         player.dailyBonus.signal_update.remove(handler_playerBonusUpdate);
      }
      
      public function get canFarm() : Boolean
      {
         return canFarmSingle || canFarmVip;
      }
      
      public function get canFarmSingle() : Boolean
      {
         return player.dailyBonus.availableSingle;
      }
      
      public function get canFarmVip() : Boolean
      {
         var _loc1_:* = null;
         if(player.dailyBonus.availableDouble)
         {
            _loc1_ = DataStorage.dailyBonus.getByDay(player.dailyBonus.day);
            return player.vipLevel.level >= _loc1_.vipLevelDouble;
         }
         return false;
      }
      
      public function get day() : int
      {
         return player.dailyBonus.day;
      }
      
      public function get activeItemIndex() : int
      {
         return day - 1;
      }
      
      public function get farmedThisMonthTimes() : int
      {
         return !!canFarmSingle?day - 1:day;
      }
      
      public function getItems() : Vector.<DailyBonusValueObject>
      {
         return items;
      }
      
      public function action_farm(param1:DailyBonusValueObject, param2:PopupStashEventParams) : void
      {
         this.stashParams = param2;
         var _loc3_:CommandDailyBonusFarm = null;
         if(param1.availableSingle && param1.availableDouble && player.vipLevel.level >= param1.vipLevelDouble && param1.vipLevelDouble > 0)
         {
            _loc3_ = GameModel.instance.actionManager.dailyBonusFarm(1,param1);
         }
         else if(param1.availableSingle)
         {
            _loc3_ = GameModel.instance.actionManager.dailyBonusFarm(0,param1);
         }
         else if(param1.availableDouble)
         {
            if(player.vipLevel.level < param1.vipLevelDouble)
            {
               PopUpManager.addPopUp(new DailyBonusPopupVipNeeded(param1.vipLevelDouble));
               return;
            }
            _loc3_ = GameModel.instance.actionManager.dailyBonusFarm(2,param1);
         }
         if(_loc3_)
         {
            _loc3_.onClientExecute(handler_getDailyBonusFarm);
         }
         else
         {
            PopUpManager.addPopUp(new MessagePopup(Translate.translateArgs("UI_DIALOG_DAILY_BONUS_WRONG_DAY",param1.day),""));
         }
      }
      
      private function updateValueObject(param1:DailyBonusValueObject, param2:Boolean) : void
      {
         var _loc3_:* = player.dailyBonus.day == param1.day;
         var _loc4_:Boolean = param1.day < player.dailyBonus.day || param1.day == player.dailyBonus.day && !player.dailyBonus.availableSingle;
         param1.update(_loc3_ && player.dailyBonus.availableSingle,_loc3_ && player.dailyBonus.availableDouble,_loc4_,_loc3_,param2);
      }
      
      private function handler_playerBonusUpdate() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = items;
         for each(var _loc1_ in items)
         {
            updateValueObject(_loc1_,true);
         }
         signal_update.dispatch();
      }
      
      private function handler_getDailyBonusFarm(param1:CommandDailyBonusFarm) : void
      {
         var _loc3_:PopupStashEventParams = Stash.click("pick_up:" + param1.vo.day,stashParams);
         var _loc2_:DailyBonusRewardPopup = new DailyBonusRewardPopup(param1.vo,param1.reward);
         _loc2_.stashSourceClick = _loc3_;
         PopUpManager.addPopUp(_loc2_);
      }
   }
}
