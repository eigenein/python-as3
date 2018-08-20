package game.mediator.gui.popup.titan
{
   import com.progrestar.common.lang.Translate;
   import feathers.controls.List;
   import feathers.data.ListCollection;
   import game.assets.storage.AssetStorage;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.titan.TitanDescription;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.hero.HeroList;
   import game.view.popup.hero.HeroListDialogBaseClip;
   import starling.events.Event;
   
   public class TitanListPopup extends ClipBasedPopup implements ITutorialActionProvider, ITutorialNodePresenter
   {
       
      
      private var mediator:TitanListPopupMediator;
      
      private var clip:HeroListDialogBaseClip;
      
      protected var list:List;
      
      public function TitanListPopup(param1:TitanListPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.TITAN_LIST;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc3_:TutorialActionsHolder = TutorialActionsHolder.create(this);
         var _loc2_:TitanDescription = param1.unit as TitanDescription;
         if(_loc2_)
         {
            scrollToUnit(_loc2_);
         }
         else
         {
            list.verticalScrollPolicy = "auto";
         }
         _loc3_.addCloseButton(clip.button_close);
         return _loc3_;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_dialog_hero_list();
         addChild(clip.graphics);
         clip.title = Translate.translate("UI_DIALOG_TITAN_LIST_TITLE");
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         clip.button_close.signal_click.add(mediator.close);
         var _loc1_:GameScrollBar = new GameScrollBar();
         _loc1_.height = clip.scroll_slider_container.container.height;
         clip.scroll_slider_container.container.addChild(_loc1_);
         list = new HeroList(_loc1_,clip.gradient_top.graphics,clip.gradient_bottom.graphics);
         list.addEventListener("rendererAdd",handler_listRendererAdded);
         list.addEventListener("rendererRemove",handler_listRendererRemoved);
         list.itemRendererType = TitanListItemRenderer;
         list.width = clip.team_list_container.graphics.width;
         list.height = clip.team_list_container.graphics.height;
         list.dataProvider = new ListCollection(mediator.data);
         clip.team_list_container.layoutGroup.addChild(list);
      }
      
      private function scrollToUnit(param1:UnitDescription) : void
      {
         var _loc4_:int = 0;
         var _loc2_:Vector.<PlayerTitanListValueObject> = mediator.data;
         var _loc3_:int = _loc2_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc2_[_loc4_].titan == param1)
            {
               list.scrollToDisplayIndex(_loc4_,0.5);
               list.verticalScrollPolicy = "off";
               return;
            }
            _loc4_++;
         }
         list.verticalScrollPolicy = "auto";
      }
      
      private function handler_listRendererAdded(param1:Event, param2:TitanListItemRenderer) : void
      {
         param2.signal_select.add(handler_heroSelect);
      }
      
      private function handler_listRendererRemoved(param1:Event, param2:TitanListItemRenderer) : void
      {
         param2.signal_select.remove(handler_heroSelect);
      }
      
      private function handler_heroSelect(param1:PlayerTitanListValueObject) : void
      {
         mediator.action_select(param1);
      }
   }
}
