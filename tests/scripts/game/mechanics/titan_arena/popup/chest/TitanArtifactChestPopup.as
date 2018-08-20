package game.mechanics.titan_arena.popup.chest
{
   import com.progrestar.common.lang.Translate;
   import engine.core.assets.AssetList;
   import engine.core.assets.RequestableAsset;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.data.storage.artifact.TitanArtifactDescription;
   import game.mechanics.titan_arena.mediator.chest.TitanArtifactChestPopupMediator;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   import game.view.popup.chest.ChestPopupTitle;
   
   public class TitanArtifactChestPopup extends AsyncClipBasedPopupWithPreloader implements ITutorialActionProvider, ITutorialNodePresenter
   {
       
      
      private var mediator:TitanArtifactChestPopupMediator;
      
      private var clip:TitanArtifactChestPopupClip;
      
      private var popupTitle:ChestPopupTitle;
      
      private var _progressAsset:RequestableAsset;
      
      public function TitanArtifactChestPopup(param1:TitanArtifactChestPopupMediator)
      {
         super(param1,AssetStorage.rsx.titan_artifact_chest_graphics);
         stashParams.windowName = "titan_artifact_chest";
         this.mediator = param1;
         this.mediator.signal_artifactChestSphereUpdate.add(updateX10);
         param1.signal_starmoneySpent.add(updateX100);
         var _loc2_:AssetList = new AssetList();
         _loc2_.addAssets(AssetStorage.rsx.titan_artifact_chest_graphics,AssetStorage.rsx.titan_artifact_icons,AssetStorage.rsx.titan_artifact_icons_large);
         _progressAsset = _loc2_;
         AssetStorage.instance.globalLoader.requestAsset(_loc2_);
      }
      
      override public function dispose() : void
      {
         mediator.signal_artifactChestSphereUpdate.remove(updateX10);
         mediator.signal_starmoneySpent.remove(updateX100);
         super.dispose();
      }
      
      override protected function get progressAsset() : RequestableAsset
      {
         return _progressAsset;
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.TITAN_VALLEY_ALTAR;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:* = null;
         if(clip == null)
         {
            return TutorialActionsHolder.create(this);
         }
         _loc2_ = TutorialActionsHolder.create(clip.graphics);
         _loc2_.addButton(TutorialNavigator.ACTION_TITAN_VALLEY_ALTAR_BUTTON,clip.cost_button_pack_key);
         _loc2_.addCloseButton(clip.button_close);
         return _loc2_;
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         var _loc7_:* = null;
         var _loc4_:int = 0;
         var _loc6_:* = null;
         var _loc5_:int = 0;
         width = 1000;
         height = 650;
         clip = param1.create(TitanArtifactChestPopupClip,"titan_artifact_chest_popup");
         addChild(clip.graphics);
         clip.button_close.signal_click.add(mediator.close);
         popupTitle = new ChestPopupTitle(Translate.translate("UI_SPIRIT_VALLEY_POPUP_ALTAR"),clip.header_layout_container);
         clip.tf_open_single.text = Translate.translate("UI_DIALOG_TITAN_ARTIFACT_CHEST_OPEN_SINGLE");
         clip.tf_open_pack_key.text = Translate.translate("UI_DIALOG_TITAN_ARTIFACT_CHEST_OPEN_PACK");
         clip.tf_open_pack.text = Translate.translate("UI_DIALOG_TITAN_ARTIFACT_CHEST_OPEN_PACK");
         clip.tf_open_pack100.text = Translate.translate("UI_DIALOG_TITAN_ARTIFACT_CHEST_OPEN_PACK100");
         clip.tf_drop.text = Translate.translate("UI_DIALOG_TITAN_ARTIFACT_CHEST_DROP");
         clip.tf_drop_pack1.text = Translate.translate("UI_DIALOG_TITAN_ARTIFACT_CHEST_DROP_PACK1");
         clip.tf_drop_pack2.text = Translate.translate("UI_DIALOG_TITAN_ARTIFACT_CHEST_DROP_PACK2");
         clip.tf_drop_column1.text = Translate.translate("UI_DIALOG_TITAN_ARTIFACT_CHEST_DROP_COLUMN_1");
         clip.tf_drop_column2.text = Translate.translate("UI_DIALOG_TITAN_ARTIFACT_CHEST_DROP_COLUMN_2");
         clip.tf_drop_column3.text = Translate.translate("UI_DIALOG_TITAN_ARTIFACT_CHEST_DROP_COLUMN_3");
         clip.cost_button_single.cost = mediator.openCostX1.outputDisplayFirst;
         clip.cost_button_pack_key.cost = mediator.openCostX10Free.outputDisplayFirst;
         clip.cost_button_pack.cost = mediator.openCostX10.outputDisplayFirst;
         clip.cost_button_pack100.cost = mediator.openCostX100.outputDisplayFirst;
         clip.cost_button_single.signal_click.add(handler_openChestSingle);
         clip.cost_button_pack_key.signal_click.add(handler_openChestPackKey);
         clip.cost_button_pack.signal_click.add(handler_openChestPack);
         clip.cost_button_pack100.signal_click.add(handler_openChestPack100);
         var _loc8_:Vector.<TitanArtifactDescription> = mediator.titanArtifactList;
         _loc4_ = 0;
         while(_loc4_ < 12)
         {
            _loc7_ = AssetStorage.rsx.popup_theme.create(TitanArtifactSmallFragmentChestItemRenderer,"artifact_desc_small_item");
            _loc7_.setData(_loc8_[_loc4_]);
            clip.layout_artifacts1.addChild(_loc7_.graphics);
            _loc4_++;
         }
         var _loc2_:Vector.<TitanArtifactDescription> = new Vector.<TitanArtifactDescription>();
         _loc2_.push(_loc8_[14]);
         _loc2_.push(_loc8_[12]);
         _loc2_.push(_loc8_[13]);
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc7_ = AssetStorage.rsx.popup_theme.create(TitanArtifactSmallFragmentChestItemRenderer,"artifact_desc_small_item");
            _loc7_.setData(_loc2_[_loc4_]);
            clip.layout_artifacts2.addChild(_loc7_.graphics);
            _loc4_++;
         }
         _loc4_ = 15;
         while(_loc4_ < 18)
         {
            _loc7_ = AssetStorage.rsx.popup_theme.create(TitanArtifactSmallFragmentChestItemRenderer,"artifact_desc_small_item");
            _loc7_.setData(_loc8_[_loc4_]);
            clip.layout_artifacts3.addChild(_loc7_.graphics);
            _loc4_++;
         }
         var _loc3_:Vector.<TitanArtifactDescription> = mediator.titanSpiritArtifactList;
         _loc5_ = 0;
         while(_loc5_ < 3)
         {
            _loc6_ = AssetStorage.rsx.popup_theme.create(TitanSpiritArtifactChestItemRenderer,"titan_spirit_artifact_chest_renderer");
            _loc6_.setData(_loc3_[_loc5_]);
            clip.layout_spirit_artifacts.addChild(_loc6_.graphics);
            _loc5_++;
         }
         updateX10();
         updateX100();
         Tutorial.updateActionsFrom(this);
      }
      
      private function updateX10() : void
      {
         if(!clip)
         {
            return;
         }
         var _loc1_:* = mediator.artifactChestKeysAmount < 10;
         clip.tf_open_single.visible = !!_loc1_?true:false;
         clip.tf_open_pack_key.visible = !!_loc1_?false:true;
         clip.cost_button_single.graphics.visible = !!_loc1_?true:false;
         clip.cost_button_pack_key.graphics.visible = !!_loc1_?false:true;
      }
      
      private function updateX100() : void
      {
         clip.cost_button_pack100.graphics.visible = mediator.x100Avaliable;
         clip.tf_open_pack100.visible = mediator.x100Avaliable;
      }
      
      private function handler_openChestPack() : void
      {
         mediator.action_open(10,false);
      }
      
      private function handler_openChestPackKey() : void
      {
         mediator.action_open(10,true);
      }
      
      private function handler_openChestPack100() : void
      {
         mediator.action_open(100,false);
      }
      
      private function handler_openChestSingle() : void
      {
         mediator.action_open(1,true);
      }
   }
}
