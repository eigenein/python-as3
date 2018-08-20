package game.mechanics.expedition.mediator
{
   import game.command.timer.GameTimer;
   import game.data.storage.hero.UnitDescription;
   import game.mechanics.expedition.model.CommandExpeditionFarm;
   import game.mechanics.expedition.model.PlayerExpeditionEntry;
   import game.mechanics.expedition.popup.ExpeditionMapPopup;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.stat.Stash;
   import game.util.TimeFormatter;
   import game.view.popup.PopupBase;
   import org.osflash.signals.Signal;
   
   public class ExpeditionMapPopupMediator extends PopupMediator implements IExpeditionValueObjectActions
   {
       
      
      private var _expeditions:Vector.<ExpeditionValueObject>;
      
      public const signal_updateAll:Signal = new Signal();
      
      public function ExpeditionMapPopupMediator(param1:Player)
      {
         _expeditions = new Vector.<ExpeditionValueObject>();
         super(param1);
         param1.expedition.requestUpdate();
         param1.expedition.list.onValue(handler_expeditions);
      }
      
      override protected function dispose() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function get timer_moreExpeditionsIn() : String
      {
         var _loc1_:int = GameTimer.instance.nextDayTimestamp - GameTimer.instance.currentServerTime;
         return TimeFormatter.toString(_loc1_);
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ExpeditionMapPopup(this);
         return new ExpeditionMapPopup(this);
      }
      
      public function getExpeditions() : Vector.<ExpeditionValueObject>
      {
         return _expeditions;
      }
      
      public function action_start(param1:ExpeditionValueObject) : void
      {
         var _loc2_:ExpeditionTeamGatherPopupMediator = new ExpeditionTeamGatherPopupMediator(player,param1);
         _loc2_.open(Stash.click("teamGather",_popup.stashParams));
         _loc2_.signal_teamGatherComplete.add(handler_teamGatherComplete);
      }
      
      public function action_farm(param1:ExpeditionValueObject) : void
      {
         var _loc2_:CommandExpeditionFarm = player.expedition.farm(param1);
         _loc2_.onClientExecute(handler_commandExpeditionFarm);
      }
      
      public function action_select(param1:ExpeditionValueObject) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(param1.isReadyToFarm)
         {
            action_farm(param1);
         }
         else
         {
            _loc3_ = new ExpeditionBriefingPopupMediator(player,param1);
            _loc3_.open(Stash.click("expedition:" + (!!param1.entry?param1.entry.id:0),_popup.stashParams));
         }
      }
      
      private function handler_teamGatherComplete(param1:ExpeditionTeamGatherPopupMediator) : void
      {
         param1.close();
         var _loc2_:Vector.<int> = new Vector.<int>();
         var _loc5_:int = 0;
         var _loc4_:* = param1.descriptionList;
         for each(var _loc3_ in param1.descriptionList)
         {
            _loc2_.push(_loc3_.id);
         }
         player.expedition.sendHeroes(param1.expedition.entry,_loc2_);
      }
      
      private function handler_expeditions(param1:Vector.<PlayerExpeditionEntry>) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function handler_commandExpeditionFarm(param1:CommandExpeditionFarm) : void
      {
         var _loc2_:ExpeditionRewardPopupMediator = new ExpeditionRewardPopupMediator(player,param1.expedition);
         _loc2_.open(Stash.click("expedition_farm:" + (!!param1.expedition.entry?param1.expedition.entry.id:0),_popup.stashParams));
      }
   }
}
