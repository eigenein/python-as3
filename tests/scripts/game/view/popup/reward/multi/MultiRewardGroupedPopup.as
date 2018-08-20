package game.view.popup.reward.multi
{
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import feathers.layout.TiledRowsLayout;
   import flash.utils.Timer;
   import game.assets.storage.AssetStorage;
   import game.command.rpc.inventory.LootBoxRewardValueObjectList;
   import game.mechanics.titan_arena.mediator.reward.TitanArenaRewardValueObjectList;
   import game.mediator.gui.component.RewardValueObject;
   import game.mediator.gui.component.RewardValueObjectList;
   import game.mediator.gui.popup.mail.MailRewardValueObjectList;
   import game.mediator.gui.popup.mission.RaidRewardValueObjectList;
   import game.model.user.inventory.InventoryItemValueObject;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   import game.view.popup.PopupBase;
   import game.view.popup.hero.TimerQueueDispenser;
   
   public class MultiRewardGroupedPopup extends PopupBase
   {
       
      
      private var reward:RewardValueObjectList;
      
      private var rewardListSource:Vector.<RewardValueObject>;
      
      private var timer:Timer;
      
      private var rewardDispencer:TimerQueueDispenser;
      
      private var listDataProvider:ListCollection;
      
      private var list:GameScrolledList;
      
      private var itemToLookFor:InventoryItemValueObject;
      
      private var clip:MultiRewardGroupedPopupClip;
      
      public function MultiRewardGroupedPopup(param1:RewardValueObjectList, param2:InventoryItemValueObject = null)
      {
         rewardDispencer = new TimerQueueDispenser(RewardValueObject,500);
         super();
         this.reward = param1;
         this.itemToLookFor = param2;
      }
      
      override public function close() : void
      {
         if(!rewardDispencer.isEmpty)
         {
            showAll();
         }
         else
         {
            if(timer)
            {
               timer.stop();
            }
            super.close();
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_popup_multi_reward();
         addChild(clip.graphics);
         var _loc1_:GameScrollBar = new GameScrollBar();
         _loc1_.height = clip.scroll_slider_container.container.height;
         clip.scroll_slider_container.container.addChild(_loc1_);
         list = new GameScrolledList(_loc1_,clip.gradient_top.graphics,clip.gradient_bottom.graphics);
         var _loc2_:TiledRowsLayout = list.layout as TiledRowsLayout;
         var _loc3_:int = 12;
         _loc2_.paddingBottom = _loc3_;
         _loc2_.paddingTop = _loc3_;
         list.matchContainer(clip.list_container.container);
         if(reward is RaidRewardValueObjectList)
         {
            list.itemRendererType = RaidRewardRenderer;
         }
         else if(reward is MailRewardValueObjectList)
         {
            list.itemRendererType = MailRewardRenderer;
         }
         else if(reward is LootBoxRewardValueObjectList)
         {
            list.itemRendererType = LootBoxRewardRenderer;
         }
         else if(reward is TitanArenaRewardValueObjectList)
         {
            list.itemRendererType = TitanArenaRewardRenderer;
         }
         clip.item_to_look_for.graphics.touchable = false;
         if(itemToLookFor)
         {
            clip.tf_looking_for.text = Translate.translate("UI_POPUP_RAID_LOOKING_FOR");
            clip.setItemLookingFor(itemToLookFor);
         }
         else
         {
            clip.setItemLookingFor(null);
         }
         rewardListSource = reward.rewardValueObjectList;
         rewardDispencer.signal_onElement.add(rewardDispencered);
         listDataProvider = new ListCollection();
         list.dataProvider = listDataProvider;
         if(rewardListSource.length <= 2)
         {
            showAll();
         }
         else
         {
            rewardDispencer.add(rewardListSource);
         }
         updateButton();
      }
      
      protected function updateButton() : void
      {
         if(rewardDispencer.isEmpty)
         {
            clip.button_farm.label = Translate.translate("UI_POPUP_RAID_REWARD_FARM");
            clip.button_farm.signal_click.add(close);
            clip.button_farm.signal_click.remove(showAll);
         }
         else
         {
            clip.button_farm.label = Translate.translate("UI_MULTIFARM_SHOW_ALL");
            clip.button_farm.signal_click.remove(close);
            clip.button_farm.signal_click.add(showAll);
         }
      }
      
      protected function rewardDispencered(param1:RewardValueObject) : void
      {
         listDataProvider.addItem(param1);
         list.scrollToDisplayIndex(listDataProvider.length - 1,0.25);
         if(rewardDispencer.isEmpty)
         {
            showAll();
         }
      }
      
      protected function showAll() : void
      {
         rewardDispencer.reset();
         var _loc2_:int = listDataProvider.length;
         var _loc1_:Number = list.verticalScrollPosition;
         listDataProvider.data = rewardListSource;
         list.verticalScrollPosition = _loc1_;
         if(rewardListSource.length != _loc2_)
         {
            list.scrollToDisplayIndex(listDataProvider.length - 1,0.25 + (rewardListSource.length - _loc2_ - 1) * 0.1);
         }
         rewardDispencer.signal_onElement.remove(rewardDispencered);
         updateButton();
      }
   }
}
