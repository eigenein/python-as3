package game.mediator.gui.popup.titan.minilist
{
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.popup.titan.TitanEntryValueObject;
   import game.view.gui.components.list.ListItemRenderer;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import idv.cjcat.signals.Signal;
   
   public class TitanPopupMiniHeroListItem extends ListItemRenderer implements ITutorialActionProvider
   {
       
      
      private var clip:TitanPopupMiniTitanListItemClip;
      
      private var _signal_select:Signal;
      
      public function TitanPopupMiniHeroListItem()
      {
         super();
         _signal_select = new Signal(TitanPopupMiniHeroListItem);
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
         Tutorial.addActionsFrom(this);
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc3_:TutorialActionsHolder = TutorialActionsHolder.create(this);
         var _loc2_:TitanEntryValueObject = data as TitanEntryValueObject;
         if(_loc2_ && !_isSelected)
         {
            _loc3_.addButtonWithKey(TutorialNavigator.TITAN_ARTIFACT,clip,_loc2_.unit);
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
         clip = AssetStorage.rsx.popup_theme.create_titan_popup_mini_item();
         clip.signal_click.add(handler_click);
         addChild(clip.graphics);
         width = clip.image_frame.graphics.width;
         height = clip.image_frame.graphics.height;
         setSelected();
      }
      
      override protected function commitData() : void
      {
         super.commitData();
         var _loc1_:TitanEntryValueObject = data as TitanEntryValueObject;
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
