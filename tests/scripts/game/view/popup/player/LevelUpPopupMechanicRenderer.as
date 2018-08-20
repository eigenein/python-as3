package game.view.popup.player
{
   import com.progrestar.common.lang.Translate;
   import feathers.controls.LayoutGroup;
   import game.assets.storage.AssetStorage;
   import game.data.storage.mechanic.MechanicDescription;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class LevelUpPopupMechanicRenderer extends LayoutGroup
   {
       
      
      private var clip:LevelUpPopupMechanicRendererClip;
      
      public var teamLevel:uint;
      
      private var _data:MechanicDescription;
      
      public function LevelUpPopupMechanicRenderer()
      {
         super();
      }
      
      public function get data() : MechanicDescription
      {
         return _data;
      }
      
      public function set data(param1:MechanicDescription) : void
      {
         if(_data == param1)
         {
            return;
         }
         _data = param1;
         invalidate("data");
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(LevelUpPopupMechanicRendererClip,"mechanic_renderer_level_up");
         addChild(clip.graphics);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid("data") && data)
         {
            if(clip)
            {
               clip.image_item.image.texture = AssetStorage.rsx.popup_theme.getTexture("mechanic_" + data.type.toLowerCase());
               clip.title_label.text = Translate.translate("UI_DIALOG_LEVEL_UP_MECHANIC_" + data.type.toUpperCase() + "_TITLE");
               if(teamLevel >= data.teamLevel)
               {
                  clip.avaliable_label.text = ColorUtils.hexToRGBFormat(15919178) + Translate.translate("UI_DIALOG_LEVEL_UP_MECHANIC_AVALIABLE");
                  clip.avaliable_label.x = clip.title_label.x + 25;
                  clip.check.graphics.visible = true;
               }
               else
               {
                  clip.avaliable_label.text = ColorUtils.hexToRGBFormat(11220276) + Translate.translateArgs("UI_DIALOG_LEVEL_UP_MECHANIC_UNAVALIABLE",data.teamLevel);
                  clip.avaliable_label.x = clip.title_label.x;
                  clip.check.graphics.visible = false;
               }
               clip.desc_label.text = Translate.translate("UI_DIALOG_LEVEL_UP_MECHANIC_" + data.type.toUpperCase());
            }
         }
      }
   }
}
