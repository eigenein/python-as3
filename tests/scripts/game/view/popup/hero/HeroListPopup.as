package game.view.popup.hero
{
   import feathers.controls.List;
   import feathers.core.ToggleGroup;
   import feathers.data.ListCollection;
   import feathers.layout.TiledRowsLayout;
   import game.assets.storage.AssetStorage;
   import game.data.storage.hero.HeroDescription;
   import game.mediator.gui.popup.hero.HeroListPopupMediator;
   import game.mediator.gui.popup.hero.PlayerHeroListValueObject;
   import game.mediator.gui.popup.socialgrouppromotion.SocialGroupPromotionFactory;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.IEscClosable;
   import game.view.popup.common.IPopupSideBarBlock;
   import game.view.popup.common.PopupSideBar;
   import starling.events.Event;
   
   public class HeroListPopup extends ClipBasedPopup implements ITutorialActionProvider, ITutorialNodePresenter, IEscClosable
   {
       
      
      protected var mediator:HeroListPopupMediator;
      
      protected var list:List;
      
      protected var asset:HeroListDialogBaseClip;
      
      protected var sideBar:PopupSideBar;
      
      public function HeroListPopup(param1:HeroListPopupMediator)
      {
         super(param1);
         this.mediator = param1;
         stashParams.windowName = "heroes";
         param1.signal_updateData.add(handler_mediatorDataUpdate);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(sideBar)
         {
            sideBar.dispose();
         }
         mediator.signal_updateData.remove(handler_mediatorDataUpdate);
         asset.button_close.signal_click.remove(close);
         mediator = null;
         asset = null;
         list.removeEventListener("rendererAdd",handler_listRendererAdded);
         list.removeEventListener("rendererRemove",handler_listRendererRemoved);
         list = null;
         sideBar = null;
      }
      
      public function get isHorizontal() : Boolean
      {
         return true;
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.HEROES;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc3_:TutorialActionsHolder = TutorialActionsHolder.create(this);
         var _loc2_:HeroDescription = param1.unit as HeroDescription;
         if(_loc2_)
         {
            scrollToHero(_loc2_);
         }
         else
         {
            list.verticalScrollPolicy = "auto";
         }
         _loc3_.addCloseButton(asset.button_close);
         return _loc3_;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         asset = createClip();
         addChild(asset.graphics);
         asset.title = mediator.title;
         width = asset.dialog_frame.graphics.width;
         height = asset.dialog_frame.graphics.height;
         var _loc3_:IPopupSideBarBlock = SocialGroupPromotionFactory.heroListSideBar();
         if(_loc3_)
         {
            sideBar = new PopupSideBar(this);
            sideBar.setBlock(_loc3_);
            addChild(sideBar.graphics);
         }
         var _loc1_:GameScrollBar = new GameScrollBar();
         _loc1_.height = asset.scroll_slider_container.container.height;
         asset.scroll_slider_container.container.addChild(_loc1_);
         list = new HeroList(_loc1_,asset.gradient_top.graphics,asset.gradient_bottom.graphics);
         list.width = asset.team_list_container.graphics.width;
         list.height = asset.team_list_container.graphics.height;
         var _loc2_:TiledRowsLayout = list.layout as TiledRowsLayout;
         _loc2_.paddingTop = 24;
         list.addEventListener("rendererAdd",handler_listRendererAdded);
         list.addEventListener("rendererRemove",handler_listRendererRemoved);
         list.itemRendererType = HeroListItemRenderer;
         list.dataProvider = new ListCollection(mediator.data);
         asset.team_list_container.layoutGroup.addChild(list);
         asset.button_close.signal_click.add(close);
      }
      
      protected function createClip() : HeroListDialogBaseClip
      {
         return AssetStorage.rsx.popup_theme.create_dialog_hero_list();
      }
      
      private function scrollToHero(param1:HeroDescription) : void
      {
         var _loc4_:int = 0;
         var _loc2_:Vector.<PlayerHeroListValueObject> = mediator.data;
         var _loc3_:int = _loc2_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc2_[_loc4_].hero == param1)
            {
               list.scrollToDisplayIndex(_loc4_,0.5);
               list.verticalScrollPolicy = "off";
               return;
            }
            _loc4_++;
         }
         list.verticalScrollPolicy = "auto";
      }
      
      private function handler_listRendererAdded(param1:Event, param2:HeroListItemRenderer) : void
      {
         param2.signal_select.add(handler_heroSelect);
         param2.signal_info.add(handler_heroInfo);
      }
      
      private function handler_listRendererRemoved(param1:Event, param2:HeroListItemRenderer) : void
      {
         param2.signal_select.remove(handler_heroSelect);
         param2.signal_info.remove(handler_heroInfo);
      }
      
      private function handler_heroSelect(param1:PlayerHeroListValueObject) : void
      {
         mediator.action_select(param1);
      }
      
      private function handler_heroInfo(param1:PlayerHeroListValueObject) : void
      {
         mediator.action_heroInfo(param1);
      }
      
      protected function handler_toggleGroupChange(param1:Event) : void
      {
         mediator.action_tabSelect((param1.target as ToggleGroup).selectedIndex);
      }
      
      private function handler_mediatorDataUpdate() : void
      {
         list.dataProvider = new ListCollection(mediator.data);
      }
   }
}
