package game.mechanics.clientoffer.model
{
   import game.mechanics.clientoffer.storage.ClientOfferBillingBonusReminderDescription;
   import game.model.user.Player;
   import game.model.user.billing.PlayerBillingDescription;
   import game.model.user.specialoffer.viewslot.ViewSlotEntry;
   import game.stat.Stash;
   import game.view.gui.tutorial.ITutorialConditionListener;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.condition.TutorialCondition;
   import game.view.gui.tutorial.condition.TutorialLibCondition;
   import starling.animation.IAnimatable;
   import starling.core.Starling;
   
   public class ClientOfferBillingBonusReminder implements ITutorialConditionListener
   {
      
      public static const IDENT:String = "billingBonusReminder";
       
      
      private var desc:ClientOfferBillingBonusReminderDescription;
      
      private var player:Player;
      
      private var enabled:Boolean = false;
      
      private var hasTriggeredCount:int = 0;
      
      private var views:Vector.<ViewSlotEntry>;
      
      private var conditions:Vector.<TutorialLibCondition>;
      
      private var delayedCall:IAnimatable;
      
      public function ClientOfferBillingBonusReminder(param1:Player, param2:ClientOfferBillingBonusReminderDescription)
      {
         conditions = new Vector.<TutorialLibCondition>();
         super();
         this.player = param1;
         this.desc = param2;
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = conditions;
         for each(var _loc1_ in conditions)
         {
            Tutorial.events.removeCondition(_loc1_);
         }
         conditions.length = 0;
      }
      
      public function init() : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = desc.getEnableWindowData();
         for each(var _loc1_ in desc.getEnableWindowData())
         {
            _loc2_ = new TutorialLibCondition(desc.enableEvent,_loc1_);
            _loc2_.listener = this;
            Tutorial.events.addCondition(_loc2_);
            conditions.push(_loc2_);
         }
         _loc2_ = new TutorialLibCondition(desc.disableEvent,desc.disableEventData);
         _loc2_.listener = this;
         Tutorial.events.addCondition(_loc2_);
         conditions.push(_loc2_);
      }
      
      public function triggerCondition(param1:TutorialCondition) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function rollChance(param1:Number) : Boolean
      {
         return Math.random() * 100 < param1;
      }
      
      protected function enable() : void
      {
         enabled = true;
         hasTriggeredCount = Number(hasTriggeredCount) + 1;
         delayedCall = Starling.juggler.delayCall(show,desc.delay);
      }
      
      protected function disable() : void
      {
         enabled = false;
         hide();
      }
      
      protected function show() : void
      {
         var _loc1_:* = null;
         if(views == null)
         {
            views = new Vector.<ViewSlotEntry>();
            var _loc4_:int = 0;
            var _loc3_:* = desc.view;
            for each(var _loc2_ in desc.view)
            {
               _loc1_ = new ViewSlotEntry(_loc2_);
               views.push(_loc1_);
            }
         }
         var _loc6_:int = 0;
         var _loc5_:* = views;
         for each(_loc1_ in views)
         {
            player.specialOffer.hooks.addViewSlotEntry(_loc1_);
         }
         delayedCall = Starling.juggler.delayCall(handler_timeEnd,desc.duration);
         Stash.sendClientStat(".client.clientOffer",{
            "ident":desc.ident,
            "action":"show"
         });
      }
      
      protected function hide() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = views;
         for each(var _loc1_ in views)
         {
            _loc1_.signal_removed.dispatch(_loc1_);
         }
         if(hasTriggeredCount == desc.timesPerSession)
         {
            dispose();
         }
      }
      
      protected function handler_timeEnd() : void
      {
         disable();
      }
   }
}
