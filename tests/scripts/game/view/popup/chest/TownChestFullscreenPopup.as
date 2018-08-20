package game.view.popup.chest
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.chest.ChestPopupMediator;
   import game.mediator.gui.popup.chest.ChestPopupValueObject;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.IEscClosable;
   import game.view.popup.common.PopupReloadController;
   
   public class TownChestFullscreenPopup extends ClipBasedPopup implements ITutorialActionProvider, ITutorialNodePresenter, IEscClosable
   {
       
      
      private var reloadController:PopupReloadController;
      
      private var clip:TownChestFullscreenPopupClip;
      
      private var mediator:ChestPopupMediator;
      
      private var chest_graphics:ChestFullscreenPopupBG;
      
      private var _goldContainer:VirtualContainer;
      
      private var _popupTitle:ChestPopupTitle;
      
      public function TownChestFullscreenPopup(param1:ChestPopupMediator)
      {
         _goldContainer = new VirtualContainer();
         super(param1);
         this.mediator = param1;
         stashParams.windowName = "chest";
         reloadController = new PopupReloadController(this,param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         reloadController.dispose();
         _goldContainer.removeAll();
         Tutorial.removeActionsFrom(this);
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.CHESTS;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:TutorialActionsHolder = TutorialActionsHolder.create(this);
         _loc2_.addButtonWithKey(TutorialNavigator.ACTION_CHEST,clip.cost_button_single,mediator.townChest.chest);
         _loc2_.addButtonWithKey(TutorialNavigator.ACTION_CHEST,clip.free_button_single,mediator.townChest.chest);
         return _loc2_;
      }
      
      override protected function initialize() : void
      {
         var _loc2_:int = 0;
         super.initialize();
         width = 1000;
         height = 650;
         chest_graphics = AssetStorage.rsx.chest_graphics.create(ChestFullscreenPopupBG,"chest_popup_graphic");
         addChild(chest_graphics.graphics);
         clip = AssetStorage.rsx.popup_theme.create(TownChestFullscreenPopupClip,"town_chest_popup_gui");
         addChild(clip.graphics);
         mediator.action_registerChestPopupOfferClip(clip);
         mediator.action_registerChestGraphicsOfferSpot(chest_graphics.bottom_gold.graphics);
         clip.blind_container.container.addChild(chest_graphics.blindSideLeft.graphics);
         clip.blind_container.container.addChild(chest_graphics.blindSideRight.graphics);
         clip.blind_container.container.addChild(chest_graphics.blindSideTop.graphics);
         _goldContainer.addChild(chest_graphics.light_gold.graphics);
         _goldContainer.addChild(chest_graphics.bottom_gold.graphics);
         _goldContainer.addChild(chest_graphics.idle_gold.graphics);
         clip.button_close.signal_click.add(mediator.close);
         chest_graphics.idle_gold.graphics.touchable = false;
         _popupTitle = new ChestPopupTitle(mediator.townChest.name,clip.header_layout_container);
         _popupTitle.minBgWidth = 550;
         clip.cost_button_single.signal_click.add(mediator.action_buySingle);
         clip.tf_open_single.text = Translate.translateArgs("UI_DIALOG_CHEST_BUTTON_GET_PACK",1);
         clip.cost_button_pack.signal_click.add(mediator.action_buyPack);
         clip.drop_block.tf_gear_rest.text = Translate.translate("UI_CHES_DROP_BLOCK_TF_GEAR_REST");
         clip.drop_block.tf_hero_rest.text = Translate.translate("UI_CHES_DROP_BLOCK_TF_HERO_REST");
         clip.drop_block.button_hero_list.signal_click.add(mediator.action_showHeroDropList);
         var _loc1_:int = clip.drop_block.hero_list.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(mediator.townChest.heroReward.length > _loc2_)
            {
               clip.drop_block.hero_list[_loc2_].setData(mediator.townChest.heroReward[_loc2_]);
            }
            else
            {
               clip.drop_block.hero_list[_loc2_].setData(null);
            }
            _loc2_++;
         }
         _loc1_ = mediator.townChest.heroMiscReward.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(clip.drop_block.gear_list.length > _loc2_)
            {
               clip.drop_block.gear_list[_loc2_].setData(mediator.townChest.heroMiscReward[_loc2_]);
            }
            _loc2_++;
         }
         _loc1_ = mediator.townChest.specialHeroReward.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(clip.drop_block.special_hero_list.length > _loc2_)
            {
               clip.drop_block.special_hero_list[_loc2_].setData(mediator.townChest.specialHeroReward[_loc2_]);
            }
            _loc2_++;
         }
         if(mediator.playerHasSuperHero)
         {
            clip.drop_block.coin_super_prize.container.visible = true;
            clip.drop_block.special_hero_list[0].container.visible = false;
            clip.drop_block.coin_super_prize.tf_1.text = Translate.translate("UI_CHES_DROP_BLOCK_TF_SUPER_PRIZE");
            if(mediator.coinSuperPrize)
            {
               clip.drop_block.coin_super_prize.tf_2.text = mediator.coinSuperPrize.name;
               clip.drop_block.coin_super_prize.tf_3.text = mediator.coinSuperPrize.amount.toString();
               clip.drop_block.coin_super_prize.item_icon.setData(mediator.coinSuperPrize);
            }
            clip.drop_block.coin_super_prize.item_icon.item_counter.graphics.visible = false;
         }
         else
         {
            clip.drop_block.coin_super_prize.container.visible = false;
            clip.drop_block.special_hero_list[0].container.visible = true;
         }
         clip.free_button_single.label = Translate.translate("UI_POPUP_CHEST_OPEN");
         clip.free_button_single.signal_click.add(mediator.action_getFreeOne);
         clip.cost_button_single.cost = mediator.townChest.cost_single;
         clip.cost_button_pack.cost = mediator.townChest.cost_multi;
         clip.tf_open_pack.text = Translate.translateArgs("UI_DIALOG_CHEST_BUTTON_GET_PACK",mediator.townChest.chest.packAmount);
         mediator.townChest.signal_update.add(handler_refillableUpdate);
         handler_refillableUpdate();
         clip.tf_chest_desc.text = Translate.translate("UI_TOWN_CHEST_POPUP_GUI_TF_CHEST_DESC");
         clip.drop_block.tf_hero_rest.text = Translate.translate("UI_CHEST_DROP_BLOCK_TF_HERO_REST");
         clip.drop_block.tf_drop_desc.text = Translate.translate("UI_CHEST_DROP_BLOCK_TF_DROP_DESC");
         clip.drop_block.tf_gear_rest.text = Translate.translate("UI_CHEST_DROP_BLOCK_TF_GEAR_REST");
         clip.tf_chest_promt.text = Translate.translate("UI_TOWN_CHEST_POPUP_GUI_TF_CHEST_PROMT");
         clip.tf_hero_drop_desc.text = Translate.translate("UI_TOWN_CHEST_POPUP_GUI_TF_HERO_DROP_DESC");
         handler_updateQuestPromoRenderer();
         mediator.signal_questPromoUpdate.add(handler_updateQuestPromoRenderer);
         Tutorial.addActionsFrom(this);
      }
      
      private function handler_refillableUpdate() : void
      {
         var _loc1_:ChestPopupValueObject = mediator.townChest;
         clip.free_button_single.graphics.visible = _loc1_.availableFreeNow;
         clip.cost_button_single.graphics.visible = !_loc1_.availableFreeNow;
         clip.tf_cooldown.text = _loc1_.cooldownFormatted;
         clip.tf_cooldown.graphics.visible = true;
      }
      
      private function handler_updateQuestPromoRenderer() : void
      {
         if(mediator.questPromo)
         {
            clip.quest_promo.graphics.visible = true;
            clip.quest_promo.setData(mediator.questPromo);
         }
         else
         {
            clip.quest_promo.graphics.visible = false;
         }
      }
   }
}
