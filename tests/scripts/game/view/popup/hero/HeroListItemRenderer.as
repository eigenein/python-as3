package game.view.popup.hero
{
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import game.mediator.gui.popup.hero.PlayerHeroListValueObject;
   import game.view.gui.components.controller.TouchClickController;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import idv.cjcat.signals.Signal;
   import starling.filters.ColorMatrixFilter;
   
   public class HeroListItemRenderer extends HeroListItemRendererBase implements ITutorialActionProvider
   {
       
      
      private var heroListPanelInventoryList:HeroListPanelInventoryList;
      
      private var colorPlusClip:HeroColorNumberClip;
      
      private var portraitClickController:TouchClickController;
      
      private var _signal_select:Signal;
      
      private var _signal_info:Signal;
      
      private var _vo:PlayerHeroListValueObject;
      
      public function HeroListItemRenderer()
      {
         super();
         _signal_select = new Signal(PlayerHeroListValueObject);
         _signal_info = new Signal(PlayerHeroListValueObject);
      }
      
      override public function dispose() : void
      {
         Tutorial.removeActionsFrom(this);
         _signal_select.clear();
         data = null;
         if(assetClip != null)
         {
            assetClip.graphics.dispose();
            clip.button_summon.signal_click.remove(listener_buttonClick);
            assetClip = null;
         }
         if(portraitClickController)
         {
            portraitClickController.dispose();
         }
         super.dispose();
         portrait = null;
      }
      
      public function get signal_select() : Signal
      {
         return _signal_select;
      }
      
      public function get signal_info() : Signal
      {
         return _signal_info;
      }
      
      public function get vo() : PlayerHeroListValueObject
      {
         return _vo;
      }
      
      protected function get clip() : HeroListDialogItemClip
      {
         return assetClip as HeroListDialogItemClip;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:TutorialActionsHolder = TutorialActionsHolder.create(this);
         if(this.vo)
         {
            _loc2_.addButtonWithKey(TutorialNavigator.HERO,assetClip.bg_button,this.vo.hero);
            _loc2_.addButtonWithKey(TutorialNavigator.ACTION_OBTAIN_HERO,clip.button_summon,this.vo.hero);
         }
         return _loc2_;
      }
      
      override protected function commitData() : void
      {
         super.commitData();
         if(vo)
         {
            updateNameColor();
            updateFragmentCount();
            heroListPanelInventoryList.visible = vo.owned;
            Tutorial.addActionsFrom(this);
         }
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:PlayerHeroListValueObject = data as PlayerHeroListValueObject;
         if(_loc2_)
         {
            _loc2_.signal_updateActionAvailable.remove(onActionAvailableUpdate);
            _loc2_.signal_updateOwnershipStatus.remove(listener_ownershipStatus);
            _loc2_.signal_updateLevel.remove(handler_levelUpdate);
            if(_loc2_.inventory)
            {
               _loc2_.inventory.signal_reset.remove(listener_inventoryUpdate);
            }
            _loc2_.signal_fragmentCountUpdate.remove(handler_fragmentCountUpdate);
         }
         .super.data = param1;
         _vo = data as PlayerHeroListValueObject;
         onActionAvailableUpdate();
         if(_vo)
         {
            _vo.signal_updateActionAvailable.add(onActionAvailableUpdate);
            _vo.signal_updateOwnershipStatus.add(listener_ownershipStatus);
            vo.signal_updateLevel.add(handler_levelUpdate);
            if(_vo.inventory)
            {
               _vo.inventory.signal_reset.add(listener_inventoryUpdate);
            }
            _vo.signal_fragmentCountUpdate.add(handler_fragmentCountUpdate);
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         heroListPanelInventoryList = new HeroListPanelInventoryList();
         heroListPanelInventoryList.width = clip.gear_list_layout_container.container.width;
         heroListPanelInventoryList.height = clip.gear_list_layout_container.container.height;
         clip.gear_list_layout_container.layoutGroup.addChild(heroListPanelInventoryList);
         clip.tf_fragment_label.text = Translate.translate("UI_DIALOG_HERO_LIST_ITEM_FRAGMENT_COUNT");
         clip.tf_fragment_count.text = "1/1";
         clip.button_summon.signal_click.add(listener_buttonClick);
         portraitClickController = new TouchClickController(portrait);
         portraitClickController.onClick.add(handler_portraiClick);
         width = clip.bg_button.graphics.width;
         height = clip.bg_button.graphics.height;
         onActionAvailableUpdate();
      }
      
      private function updateFragmentCount() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = !vo.owned && !vo.canCraft;
         clip.layout_fragment_count.graphics.visible = _loc2_;
         clip.fragmentsProgressbar.graphics.visible = _loc2_;
         clip.tf_fragment_count.text = vo.fragmentCount + "/" + vo.maxFragments;
         clip.fragmentsProgressbar.value = Math.min(1,vo.fragmentCount / vo.maxFragments);
         clip.bg_button.isEnabled = vo.owned || !vo.canCraft;
         if(portrait.filter)
         {
            portrait.filter.dispose();
            portrait.filter = null;
         }
         if(vo.owned)
         {
            if(vo.inventory)
            {
               heroListPanelInventoryList.dataProvider = new ListCollection(vo.inventory.inventory);
            }
            portrait.filter = null;
            portrait.alpha = 1;
         }
         else if(vo.canCraft)
         {
            portrait.filter = null;
            portrait.alpha = 1;
         }
         else
         {
            portrait.alpha = 0.4;
            _loc1_ = new ColorMatrixFilter();
            _loc1_.adjustSaturation(-1);
            portrait.filter = _loc1_;
         }
         _loc2_ = !vo.owned && vo.canCraft;
         clip.button_summon.graphics.visible = _loc2_;
         _loc2_ = _loc2_;
         clip.sun_glow.graphics.visible = _loc2_;
         _loc2_ = _loc2_;
         portrait.parent.touchable = _loc2_;
         portrait.parent.useHandCursor = _loc2_;
      }
      
      private function updateNameColor() : void
      {
         if(colorPlusClip)
         {
            colorPlusClip.dispose();
         }
         colorPlusClip = HeroColorNumberClip.create(vo.color,true);
         if(colorPlusClip)
         {
            clip.layout_name.addChild(colorPlusClip.graphics);
         }
         clip.tf_hero_name.text = vo.name;
      }
      
      override protected function listener_buttonClick() : void
      {
         _signal_select.dispatch(data as PlayerHeroListValueObject);
      }
      
      private function onActionAvailableUpdate() : void
      {
         if(assetClip)
         {
            clip.NewIcon_inst0.graphics.visible = vo && vo.redDotState;
         }
      }
      
      private function listener_inventoryUpdate() : void
      {
         if(vo && vo.inventory)
         {
            heroListPanelInventoryList.dataProvider = new ListCollection(vo.inventory.inventory);
         }
      }
      
      private function listener_ownershipStatus() : void
      {
         invalidate("data");
         if(_vo.inventory)
         {
            _vo.inventory.signal_reset.add(listener_inventoryUpdate);
         }
      }
      
      private function handler_levelUpdate() : void
      {
         portrait.update_level();
      }
      
      private function handler_fragmentCountUpdate() : void
      {
         updateFragmentCount();
      }
      
      private function handler_portraiClick() : void
      {
         _signal_info.dispatch(data as PlayerHeroListValueObject);
      }
      
      override protected function listener_heroPromote() : void
      {
         super.listener_heroPromote();
         updateNameColor();
      }
   }
}
