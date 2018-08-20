package game.view.popup.artifacts
{
   import engine.core.assets.AssetList;
   import engine.core.assets.RequestableAsset;
   import feathers.controls.List;
   import feathers.data.ListCollection;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.data.storage.hero.UnitDescription;
   import game.mediator.gui.popup.artifacts.PlayerTitanArtifactVO;
   import game.mediator.gui.popup.artifacts.PlayerTitanWithArtifactsVO;
   import game.mediator.gui.popup.artifacts.TitanArtifactsPopupMediator;
   import game.mediator.gui.popup.titan.PlayerTitanEntryValueObject;
   import game.mediator.gui.popup.titan.minilist.TitanPopupMiniHeroList;
   import game.model.user.hero.PlayerTitanArtifact;
   import game.model.user.hero.PlayerTitanEntry;
   import game.view.gui.components.controller.TouchHoverContoller;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   import game.view.popup.IEscClosable;
   import starling.events.Event;
   
   public class TitanArtifactsPopup extends AsyncClipBasedPopupWithPreloader implements ITutorialActionProvider, ITutorialNodePresenter, IEscClosable
   {
       
      
      private var _progressAsset:RequestableAsset;
      
      private var mediator:TitanArtifactsPopupMediator;
      
      private var evolutionHover:TouchHoverContoller;
      
      private var levelUpHover1:TouchHoverContoller;
      
      private var levelUpHover2:TouchHoverContoller;
      
      private var clip:TitanArtifactsPopupClip;
      
      private var miniList:TitanPopupMiniHeroList;
      
      private var artifatsList:List;
      
      public function TitanArtifactsPopup(param1:TitanArtifactsPopupMediator)
      {
         super(param1,AssetStorage.rsx.artifact_graphics);
         this.mediator = param1;
         var _loc2_:AssetList = new AssetList();
         _loc2_.addAssets(AssetStorage.rsx.titan_artifact_icons_large,AssetStorage.rsx.artifact_graphics);
         _progressAsset = _loc2_;
         AssetStorage.instance.globalLoader.requestAsset(_loc2_);
      }
      
      override public function dispose() : void
      {
         mediator.signal_titanUpdated.remove(handler_titanUpdate);
         mediator.signal_artifactUpdated.remove(handler_artifactUpdate);
         mediator.signal_titanArtifactEvolveStar.remove(handler_titanArtifactEvolveStar);
         mediator.signal_titanArtifactLevelUp.remove(handler_titanArtifactLevelUp);
         if(miniList)
         {
            miniList.removeEventListener("change",handler_miniListSelectionChange);
         }
         if(artifatsList)
         {
            artifatsList.removeEventListener("change",handler_artifactsListSelectionChange);
         }
         if(clip)
         {
            clip.evolve_clip.craft_recipe_list.signal_itemSelected.remove(mediator.action_selectRecipeItem);
            clip.info.dispose();
         }
         if(evolutionHover)
         {
            evolutionHover.dispose();
         }
         if(levelUpHover1)
         {
            levelUpHover1.dispose();
         }
         if(levelUpHover2)
         {
            levelUpHover2.dispose();
         }
         super.dispose();
      }
      
      override protected function get progressAsset() : RequestableAsset
      {
         return _progressAsset;
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.TITAN_ARTIFACT;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         height = 500;
         mediator.signal_titanUpdated.add(handler_titanUpdate);
         mediator.signal_artifactUpdated.add(handler_artifactUpdate);
         mediator.signal_titanArtifactEvolveStar.add(handler_titanArtifactEvolveStar);
         mediator.signal_titanArtifactLevelUp.add(handler_titanArtifactLevelUp);
         clip = AssetStorage.rsx.artifact_graphics.create(TitanArtifactsPopupClip,"dialog_titan_artifacts");
         addChild(clip.graphics);
         clip.button_close.signal_click.add(mediator.close);
         TitanArtifactListRenderer.mediator = mediator;
         artifatsList = new List();
         artifatsList.addEventListener("change",handler_artifactsListSelectionChange);
         artifatsList.layout = new VerticalLayout();
         (artifatsList.layout as VerticalLayout).gap = -7;
         artifatsList.itemRendererType = TitanArtifactListRenderer;
         artifatsList.horizontalScrollPolicy = "off";
         artifatsList.verticalScrollPolicy = "off";
         artifatsList.width = clip.artifacts_list_container.container.width;
         artifatsList.height = clip.artifacts_list_container.container.height;
         clip.artifacts_list_container.container.addChild(artifatsList);
         createMiniList();
         clip.evolve_clip.mediator = mediator;
         clip.level_up_clip.mediator = mediator;
         clip.info.mediator = mediator;
         clip.evolve_clip.craft_recipe_list.signal_itemSelected.add(mediator.action_selectRecipeItem);
         evolutionHover = new TouchHoverContoller(clip.evolve_clip.action_button.container);
         evolutionHover.signal_hoverChanger.add(handler_evolutionHoverChanged);
         levelUpHover1 = new TouchHoverContoller(clip.level_up_clip.button_level_up_1.container);
         levelUpHover1.signal_hoverChanger.add(handler_levelUpHover1Changed);
         levelUpHover2 = new TouchHoverContoller(clip.level_up_clip.button_level_up_2.container);
         levelUpHover2.signal_hoverChanger.add(handler_levelUpHover2Changed);
         handler_titanUpdate();
         addEventListener("addedToStage",handler_addedToStage);
      }
      
      private function handler_titanUpdate() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = int(artifatsList.selectedIndex);
         artifatsList.dataProvider = new ListCollection(mediator.titanArtifactsList);
         if(mediator.selectedArtifact)
         {
            _loc1_ = 0;
            while(_loc1_ < artifatsList.dataProvider.length)
            {
               if((artifatsList.dataProvider.getItemAt(_loc1_) as PlayerTitanArtifactVO).artifact.desc == mediator.selectedArtifact)
               {
                  _loc2_ = _loc1_;
                  break;
               }
               _loc1_++;
            }
         }
         artifatsList.selectedIndex = _loc2_ >= 0?_loc2_:0;
         Tutorial.updateActionsFrom(this);
      }
      
      private function createMiniList() : void
      {
         miniList = new TitanPopupMiniHeroList(clip.minilist_layout_container,clip.miniList_leftArrow,clip.miniList_rightArrow);
         miniList.dataProvider = mediator.miniTitanListDataProvider;
         miniList.selectedItem = mediator.miniTitanListSelectedItem;
         miniList.addEventListener("change",handler_miniListSelectionChange);
      }
      
      private function handler_miniListSelectionChange(param1:Event) : void
      {
         mediator.action_miniListSelectionUpdate(miniList.selectedItem as PlayerTitanWithArtifactsVO);
         miniList.selectedItem = mediator.miniTitanListSelectedItem;
      }
      
      private function handler_artifactsListSelectionChange(param1:Event) : void
      {
         mediator.selectedArtifact = null;
         mediator.action_artifactsListSelectionUpdate(artifatsList.selectedItem as PlayerTitanArtifactVO);
      }
      
      private function handler_artifactUpdate() : void
      {
         clip.info.updateState();
         clip.evolve_clip.updateState();
         clip.level_up_clip.updateState();
      }
      
      private function handler_titanArtifactEvolveStar(param1:PlayerTitanEntry, param2:PlayerTitanArtifact) : void
      {
         clip.info.updateState(true,false);
         clip.evolve_clip.updateState();
         clip.level_up_clip.updateState();
         Tutorial.updateActionsFrom(this);
      }
      
      private function handler_titanArtifactLevelUp(param1:PlayerTitanEntry, param2:PlayerTitanArtifact) : void
      {
         clip.info.updateState(false,true);
         clip.evolve_clip.updateState();
         clip.level_up_clip.updateState();
         Tutorial.updateActionsFrom(this);
      }
      
      private function handler_evolutionHoverChanged() : void
      {
         clip.info.updateStats(evolutionHover.hover,false);
      }
      
      private function handler_levelUpHover1Changed() : void
      {
         clip.info.updateStats(false,levelUpHover1.hover);
      }
      
      private function handler_levelUpHover2Changed() : void
      {
         clip.info.updateStats(false,levelUpHover2.hover);
      }
      
      private function handler_addedToStage(param1:Event) : void
      {
      }
   }
}
