package game.mechanics
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.view.popup.ClipBasedPopup;
   
   public class MechanicNotEnoughLevelPopup extends ClipBasedPopup
   {
       
      
      private var mediator:MechanicNotEnoughLevelPopupMediator;
      
      private var clip:MechanicNotEnoughLevelPopupClip;
      
      private var renderer:MechanicNotEnoughLevelPopupRenderer;
      
      public function MechanicNotEnoughLevelPopup(param1:MechanicNotEnoughLevelPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override public function close() : void
      {
         renderer.image.dispose();
         super.close();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(MechanicNotEnoughLevelPopupClip,"mechanic_not_enough_level_popup");
         addChild(clip.graphics);
         clip.tf_footer.text = Translate.translate("UI_BOSS_NOT_ENOUGH_LEVEL_POPUP_TF_FOOTER");
         clip.tf_header.text = Translate.translateArgs("UI_NOT_ENOUGH_LEVEL_POPUP_TF_HEADER_MECHANIC_" + mediator.mechanicType.toUpperCase(),mediator.level);
         clip.tf_caption.text = Translate.translateArgs("UI_NOT_ENOUGH_LEVEL_POPUP_TF_CAPTION_MECHANIC_" + mediator.mechanicType.toUpperCase(),mediator.level);
         clip.button_ok.label = Translate.translate("UI_COMMON_OK");
         clip.button_ok.signal_click.add(close);
         if(mediator.isClanMechanic())
         {
            renderer = AssetStorage.rsx.popup_theme.create(MechanicClanNotEnoughLevelPopupRenderer,"clan_mechanic_not_enough_level_popup");
         }
         else
         {
            renderer = AssetStorage.rsx.popup_theme.create(MechanicNotEnoughLevelPopupRenderer,"renderer_mechanic_not_enough_level_popup");
         }
         renderer.image.load(mediator.mechanicType + "_level_req.jpg");
         renderer.graphics.x = clip.image_marker.container.x;
         renderer.graphics.y = clip.image_marker.container.y;
         clip.container.addChild(renderer.graphics);
      }
   }
}
