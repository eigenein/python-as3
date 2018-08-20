package game.mediator.gui.popup.titan
{
   import com.progrestar.common.lang.Translate;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import game.view.popup.hero.HeroListDialogItemClip;
   import idv.cjcat.signals.Signal;
   import starling.filters.ColorMatrixFilter;
   
   public class TitanListItemRenderer extends TitanListItemRendererBase implements ITutorialActionProvider
   {
       
      
      private var _signal_select:Signal;
      
      private var _vo:PlayerTitanListValueObject;
      
      public function TitanListItemRenderer()
      {
         super();
         _signal_select = new Signal(PlayerTitanListValueObject);
      }
      
      override public function dispose() : void
      {
         Tutorial.removeActionsFrom(this);
         _signal_select.clear();
         clip.button_summon.signal_click.remove(listener_buttonClick);
         data = null;
         assetClip = null;
         super.dispose();
         portrait = null;
      }
      
      public function get signal_select() : Signal
      {
         return _signal_select;
      }
      
      public function get vo() : PlayerTitanListValueObject
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
            _loc2_.addButtonWithKey(TutorialNavigator.TITAN,assetClip.bg_button,this.vo.titan);
            _loc2_.addButtonWithKey(TutorialNavigator.ACTION_TITAN_OBTAIN,clip.button_summon,this.vo.titan);
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
            Tutorial.addActionsFrom(this);
         }
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:PlayerTitanListValueObject = data as PlayerTitanListValueObject;
         if(_loc2_)
         {
            _loc2_.signal_updateActionAvailable.remove(onActionAvailableUpdate);
            _loc2_.signal_updateOwnershipStatus.remove(listener_ownershipStatus);
            _loc2_.signal_updateLevel.remove(handler_levelUpdate);
            _loc2_.signal_fragmentCountUpdate.remove(handler_fragmentCountUpdate);
         }
         .super.data = param1;
         _vo = data as PlayerTitanListValueObject;
         onActionAvailableUpdate();
         if(_vo)
         {
            _vo.signal_updateActionAvailable.add(onActionAvailableUpdate);
            _vo.signal_updateOwnershipStatus.add(listener_ownershipStatus);
            vo.signal_updateLevel.add(handler_levelUpdate);
            _vo.signal_fragmentCountUpdate.add(handler_fragmentCountUpdate);
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip.tf_fragment_label.text = Translate.translate("UI_DIALOG_HERO_LIST_ITEM_FRAGMENT_COUNT");
         clip.tf_fragment_count.text = "1/1";
         clip.button_summon.signal_click.add(listener_buttonClick);
         width = clip.bg_button.graphics.width;
         height = clip.bg_button.graphics.height;
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
         clip.sun_glow.graphics.visible = _loc2_;
      }
      
      private function updateNameColor() : void
      {
         clip.tf_hero_name.text = vo.name;
         clip.tf_desc_label.text = vo.descText;
         clip.layout_desc.graphics.visible = vo.owned;
         if(vo.owned)
         {
            clip.layout_name.y = 30;
            clip.layout_desc.y = clip.layout_name.y + 26;
         }
         else
         {
            clip.layout_name.y = 17;
            clip.layout_desc.y = clip.layout_name.y + 26;
         }
      }
      
      override protected function listener_buttonClick() : void
      {
         _signal_select.dispatch(data as PlayerTitanListValueObject);
      }
      
      private function onActionAvailableUpdate() : void
      {
         clip.NewIcon_inst0.graphics.visible = vo && vo.redDotState;
      }
      
      private function listener_ownershipStatus() : void
      {
         invalidate("data");
      }
      
      private function handler_levelUpdate() : void
      {
         portrait.update_level();
      }
      
      private function handler_fragmentCountUpdate() : void
      {
         updateFragmentCount();
      }
      
      override protected function listener_titanPromote() : void
      {
         super.listener_titanPromote();
         updateNameColor();
      }
   }
}
