package game.view.popup.hero.minilist
{
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.hero.HeroEntryValueObject;
   import game.mediator.gui.popup.hero.PlayerHeroListValueObject;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.view.gui.components.list.ListItemRenderer;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import idv.cjcat.signals.Signal;
   
   public class HeroPopupMiniHeroListItem extends ListItemRenderer implements ITutorialActionProvider
   {
       
      
      protected var clip:HeroPopupMiniHeroListItemClip;
      
      private var _signal_select:Signal;
      
      public function HeroPopupMiniHeroListItem()
      {
         super();
         _signal_select = new Signal(HeroPopupMiniHeroListItem);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         clip.data = null;
      }
      
      public function get signal_select() : Signal
      {
         return _signal_select;
      }
      
      override public function get isSelected() : Boolean
      {
         return _isSelected;
      }
      
      override public function set isSelected(param1:Boolean) : void
      {
         if(_isSelected == param1)
         {
            return;
         }
         _isSelected = param1;
         setSelected();
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc3_:TutorialActionsHolder = TutorialActionsHolder.create(this);
         var _loc2_:PlayerHeroListValueObject = data as PlayerHeroListValueObject;
         if(_loc2_)
         {
            _loc3_.addButtonWithKey(TutorialNavigator.HERO,clip,_loc2_.hero);
         }
         return _loc3_;
      }
      
      protected function setSelected() : void
      {
         if(!clip)
         {
            return;
         }
         clip.glow_select.graphics.visible = _isSelected;
         AssetStorage.rsx.popup_theme.setDisabledFilter(clip.image_item.graphics,!_isSelected);
         AssetStorage.rsx.popup_theme.setDisabledFilter(clip.image_bg.graphics,!_isSelected);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = createClip();
         clip.signal_click.add(handler_click);
         addChild(clip.graphics);
         width = clip.image_frame.graphics.width;
         height = clip.image_frame.graphics.height;
         setSelected();
      }
      
      protected function createClip() : HeroPopupMiniHeroListItemClip
      {
         return AssetStorage.rsx.popup_theme.create_hero_popup_mini_item();
      }
      
      override protected function commitData() : void
      {
         super.commitData();
         var _loc1_:HeroEntryValueObject = data as HeroEntryValueObject;
         if(_loc1_)
         {
            clip.data = _loc1_;
         }
         Tutorial.addActionsFrom(this);
      }
      
      private function handler_click(param1:UnitEntryValueObject) : void
      {
         if(!_isSelected)
         {
            isSelected = true;
            _signal_select.dispatch(this);
         }
      }
   }
}
