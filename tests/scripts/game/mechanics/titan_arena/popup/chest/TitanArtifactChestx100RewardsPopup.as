package game.mechanics.titan_arena.popup.chest
{
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import game.assets.storage.AssetStorage;
   import game.mechanics.titan_arena.mediator.chest.TitanArtifactChestx100RewardsPopupMediator;
   import game.view.gui.components.GameScrollBar;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.artifactchest.rewardpopup.ArtifactChestRewardPopupItemRendererWithMultiplier;
   import game.view.popup.dailybonus.DailyBonusPopupClip;
   import game.view.popup.dailybonus.DailyBonusPopupList;
   
   public class TitanArtifactChestx100RewardsPopup extends ClipBasedPopup
   {
       
      
      private var mediator:TitanArtifactChestx100RewardsPopupMediator;
      
      public function TitanArtifactChestx100RewardsPopup(param1:TitanArtifactChestx100RewardsPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc3_:DailyBonusPopupClip = AssetStorage.rsx.popup_theme.create_dialog_daily_bonus();
         addChild(_loc3_.graphics);
         width = _loc3_.dialog_frame.graphics.width;
         height = _loc3_.dialog_frame.graphics.height;
         _loc3_.title = Translate.translate("UI_SPIRIT_VALLEY_POPUP_ALTAR");
         _loc3_.tf_caption.text = Translate.translate("UI_DIALOG_TITAN_ARTIFACT_CHEST_REWARD");
         _loc3_.button_close.signal_click.add(mediator.close);
         var _loc1_:GameScrollBar = new GameScrollBar();
         _loc1_.height = _loc3_.scroll_slider_container.container.height;
         _loc3_.scroll_slider_container.container.addChild(_loc1_);
         _loc3_.gradient_top.graphics.visible = false;
         _loc3_.gradient_bottom.graphics.visible = false;
         var _loc2_:DailyBonusPopupList = new DailyBonusPopupList(_loc1_);
         _loc2_.width = _loc3_.list_container.container.width;
         _loc2_.height = _loc3_.list_container.container.height;
         _loc3_.list_container.container.addChild(_loc2_);
         _loc2_.itemRendererType = ArtifactChestRewardPopupItemRendererWithMultiplier;
         _loc2_.dataProvider = new ListCollection(mediator.rewardsList);
      }
   }
}
