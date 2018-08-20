package game.view.popup.titan
{
   import com.progrestar.common.lang.Translate;
   import engine.core.assets.AssetProgressProvider;
   import feathers.controls.List;
   import feathers.data.ListCollection;
   import feathers.layout.TiledRowsLayout;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.data.storage.titan.TitanDescription;
   import game.mediator.gui.popup.titan.PlayerTitanListValueObject;
   import game.mediator.gui.popup.titan.TitanArtifactListPopupMediator;
   import game.view.gui.components.ClipProgressBar;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import game.view.popup.AsyncClipBasedPopup;
   import game.view.popup.IEscClosable;
   import game.view.popup.common.PopupTitle;
   import game.view.popup.hero.HeroList;
   import game.view.popup.hero.HeroListDialogClip;
   import starling.events.Event;
   
   public class TitanArtifactListPopup extends AsyncClipBasedPopup implements ITutorialActionProvider, ITutorialNodePresenter, IEscClosable
   {
       
      
      private var mediator:TitanArtifactListPopupMediator;
      
      private var clip:HeroListDialogClip;
      
      private var list:List;
      
      private var slider:GameScrollBar;
      
      private var progressbar:ClipProgressBar;
      
      private var assetProgress:AssetProgressProvider;
      
      public function TitanArtifactListPopup(param1:TitanArtifactListPopupMediator)
      {
         super(param1,AssetStorage.rsx.titan_artifact_icons);
         this.mediator = param1;
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.TITAN_VALLEY_ARTIFACTS;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc3_:TutorialActionsHolder = TutorialActionsHolder.create(this);
         var _loc2_:TitanDescription = param1.unit as TitanDescription;
         if(_loc2_)
         {
            scrollToTitan(_loc2_);
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
         if(!asset.completed)
         {
            progressbar = AssetStorage.rsx.popup_theme.create_component_progressbar();
            addChild(progressbar.graphics);
            assetProgress = AssetStorage.instance.globalLoader.getAssetProgress(asset);
            if(!assetProgress.completed)
            {
               assetProgress.signal_onProgress.add(handler_assetProgress);
               handler_assetProgress(assetProgress);
            }
         }
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         height = 500;
         if(progressbar)
         {
            removeChild(progressbar.graphics);
         }
         if(assetProgress)
         {
            assetProgress.signal_onProgress.remove(handler_assetProgress);
         }
         clip = AssetStorage.rsx.popup_theme.create_dialog_hero_artifact_list();
         addChild(clip.graphics);
         PopupTitle.create(Translate.translate("UI_DIALOG_TITAN_ARTIFACT_LIST_TITLE"),clip.header_layout_container);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         slider = new GameScrollBar();
         slider.height = clip.scroll_slider_container.container.height;
         clip.scroll_slider_container.container.addChild(slider);
         clip.button_close.signal_click.add(close);
         list = new HeroList(slider,clip.gradient_top.graphics,clip.gradient_bottom.graphics);
         list.width = clip.team_list_container.graphics.width;
         list.height = clip.team_list_container.graphics.height;
         (list.layout as TiledRowsLayout).paddingTop = 24;
         list.addEventListener("rendererAdd",handler_listRendererAdded);
         list.addEventListener("rendererRemove",handler_listRendererRemoved);
         list.itemRendererType = TitanArtifactListItemRenderer;
         list.dataProvider = new ListCollection(mediator.data);
         clip.team_list_container.layoutGroup.addChild(list);
         Tutorial.addActionsFrom(this);
      }
      
      private function scrollToTitan(param1:TitanDescription) : void
      {
         var _loc4_:int = 0;
         var _loc2_:Vector.<PlayerTitanListValueObject> = mediator.data;
         var _loc3_:int = _loc2_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc2_[_loc4_].unit == param1)
            {
               list.scrollToDisplayIndex(_loc4_,0.5);
               list.verticalScrollPolicy = "off";
               return;
            }
            _loc4_++;
         }
         list.verticalScrollPolicy = "auto";
      }
      
      private function handler_assetProgress(param1:AssetProgressProvider) : void
      {
         if(progressbar)
         {
            progressbar.maxValue = param1.progressTotal;
            progressbar.value = param1.progressCurrent;
         }
      }
      
      private function handler_listRendererAdded(param1:Event, param2:TitanArtifactListItemRenderer) : void
      {
         param2.signal_select.add(handler_titanSelect);
      }
      
      private function handler_listRendererRemoved(param1:Event, param2:TitanArtifactListItemRenderer) : void
      {
         param2.signal_select.remove(handler_titanSelect);
      }
      
      private function handler_titanSelect(param1:PlayerTitanListValueObject) : void
      {
         mediator.action_select(param1);
      }
   }
}
