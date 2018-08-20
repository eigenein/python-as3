package game.view.popup.activity
{
   import com.progrestar.common.lang.Translate;
   import feathers.controls.LayoutGroup;
   import feathers.data.ListCollection;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.data.reward.RewardData;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.quest.PlayerQuestEntry;
   import game.model.user.quest.PlayerQuestValueObject;
   import game.view.gui.components.GameScrolledAlphaGradientList;
   import starling.animation.Juggler;
   import starling.core.Starling;
   import starling.display.DisplayObjectContainer;
   import starling.events.Event;
   
   public class ChainEventQuestsView extends LayoutGroup
   {
       
      
      private var mediator:SpecialQuestEventPopupMediator;
      
      private var clip:ChainEventQuestsViewClip;
      
      private var chainQuestsList:ChainQuestsList;
      
      private var questList:GameScrolledAlphaGradientList;
      
      private var juggler:Juggler;
      
      private var dropLayer:SpecialQuestEventDropLayer;
      
      private var _event:QuestEventSpecialValueObject;
      
      public function ChainEventQuestsView(param1:SpecialQuestEventPopupMediator, param2:SpecialQuestEventDropLayer)
      {
         juggler = new Juggler();
         super();
         this.mediator = param1;
         this.dropLayer = param2;
         param1.signal_questRemoved.add(onQuestRemoved);
         param1.signal_dropReward.add(handler_dropReward);
         addEventListener("addedToStage",handler_addedToStage);
         addEventListener("removedFromStage",handler_removedFromStage);
      }
      
      private function handler_addedToStage(param1:Event) : void
      {
         Starling.juggler.add(juggler);
      }
      
      private function handler_removedFromStage(param1:Event) : void
      {
         Starling.juggler.remove(juggler);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         mediator.signal_questRemoved.remove(onQuestRemoved);
         mediator.signal_dropReward.remove(handler_dropReward);
         removeEventListener("addedToStage",handler_addedToStage);
         removeEventListener("removedFromStage",handler_removedFromStage);
         juggler.purge();
      }
      
      public function get event() : QuestEventSpecialValueObject
      {
         return _event;
      }
      
      public function set event(param1:QuestEventSpecialValueObject) : void
      {
         if(event == param1)
         {
            return;
         }
         _event = param1;
         invalidate("data");
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_view_chain_event_quests();
         addChild(clip.graphics);
         chainQuestsList = new ChainQuestsList(null,null,null);
         chainQuestsList.width = clip.chain_list_container.container.width;
         chainQuestsList.height = clip.chain_list_container.container.height;
         clip.chain_list_container.container.addChild(chainQuestsList);
         chainQuestsList.itemRendererType = ChainQuestsListRenderer;
         chainQuestsList.addEventListener("change",handler_changeQuestChain);
         chainQuestsList.verticalScrollPolicy = "off";
         questList = clip.quest_list;
         var _loc1_:VerticalLayout = new VerticalLayout();
         _loc1_.paddingTop = 14;
         _loc1_.paddingBottom = 12;
         _loc1_.gap = 10;
         _loc1_.hasVariableItemDimensions = true;
         questList.snapScrollPositionsToPixels = true;
         questList.layout = _loc1_;
         questList.addEventListener("rendererAdd",onQuestListRendererAdded);
         questList.addEventListener("rendererRemove",onQuestListRendererRemoved);
         questList.itemRendererType = SpecialQuestListItemRenderer;
      }
      
      override protected function draw() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function updateQuestList(param1:SpecialQuestEventChainTabValueObject) : void
      {
         var _loc2_:* = null;
         if(param1)
         {
            clip.custom_content.container.removeChildren();
            if(param1.chainDescription)
            {
               clip.showQuestList = true;
               questList.dataProvider = new ListCollection(mediator.getQuestListByEventChainId(param1.chainDescription.id));
               updateEmptyState();
               if(mediator.getSpecialListDailyFlagByEventChainId(param1.chainDescription.id))
               {
                  clip.tf_quest_caption.text = Translate.translate("UI_DIALOG_ACTIVITY_DAILY_QUESTS_DESC");
                  clip.tf_empty.text = Translate.translate("UI_SPECIALQUEST_CHAIN_COMPLETE_DAILY");
               }
               else
               {
                  clip.tf_quest_caption.text = Translate.translate("UI_DIALOG_ACTIVITY_QUESTS_DESC");
                  clip.tf_empty.text = Translate.translate("UI_SPECIALQUEST_CHAIN_COMPLETE");
               }
            }
            else
            {
               clip.showQuestList = false;
               _loc2_ = param1 as CustomSpecialQuestEventChainTabValueObject;
               clip.custom_content.container.addChild(_loc2_.tab.graphics);
               questList.dataProvider = null;
            }
            juggler.purge();
         }
      }
      
      private function updateEmptyState() : void
      {
         clip.tf_empty.visible = questList.dataProvider.length == 0;
      }
      
      private function onQuestListRendererAdded(param1:Event, param2:SpecialQuestListItemRenderer) : void
      {
         param2.signal_select.add(onQuestSelectSignal);
         param2.signal_farm.add(onQuestFarmSignal);
      }
      
      private function onQuestListRendererRemoved(param1:Event, param2:SpecialQuestListItemRenderer) : void
      {
         param2.signal_select.remove(onQuestSelectSignal);
         param2.signal_farm.remove(onQuestFarmSignal);
      }
      
      private function onQuestSelectSignal(param1:PlayerQuestValueObject) : void
      {
         mediator.action_quest_select(param1);
      }
      
      private function onQuestFarmSignal(param1:PlayerQuestValueObject) : void
      {
         mediator.action_quest_farm(param1);
      }
      
      private function handler_changeQuestChain(param1:Event) : void
      {
         if(chainQuestsList.selectedItem)
         {
            updateQuestList(chainQuestsList.selectedItem as SpecialQuestEventChainTabValueObject);
         }
      }
      
      private function onQuestRemoved(param1:PlayerQuestEntry) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = questList.dataProvider.data;
         for each(var _loc2_ in questList.dataProvider.data)
         {
            if(_loc2_.entry == param1)
            {
               juggler.tween(_loc2_.removeAnimationProgress,0.5,{
                  "value":1,
                  "transition":"easeOut",
                  "onComplete":handler_removeAnimationComplete,
                  "onCompleteArgs":[_loc2_]
               });
               break;
            }
         }
      }
      
      private function handler_removeAnimationComplete(param1:PlayerQuestValueObject) : void
      {
         questList.dataProvider.removeItem(param1);
         updateEmptyState();
      }
      
      private function handler_dropReward(param1:RewardData, param2:PlayerQuestEntry) : void
      {
         var _loc5_:* = null;
         var _loc7_:int = 0;
         var _loc6_:* = null;
         var _loc10_:* = undefined;
         var _loc8_:int = 0;
         var _loc3_:* = null;
         var _loc4_:DisplayObjectContainer = questList.getChildAt(0) as DisplayObjectContainer;
         var _loc9_:int = _loc4_.numChildren;
         _loc7_ = 0;
         while(_loc7_ < _loc9_)
         {
            _loc6_ = _loc4_.getChildAt(_loc7_) as SpecialQuestListItemRenderer;
            if(_loc6_ != null && (_loc6_.data as PlayerQuestValueObject).entry == param2)
            {
               _loc10_ = (_loc6_.data as PlayerQuestValueObject).rewards;
               _loc8_ = 0;
               while(_loc8_ < _loc10_.length)
               {
                  if(_loc8_ < _loc6_.clip.reward_items.length)
                  {
                     _loc3_ = _loc10_[_loc8_];
                     dropLayer.dropReward(_loc3_.item,_loc3_.amount,_loc6_.clip.reward_items[_loc8_].graphics);
                     _loc8_++;
                     continue;
                  }
                  break;
               }
               break;
            }
            _loc7_++;
         }
      }
   }
}
