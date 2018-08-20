package game.view.popup.tower
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.tower.TowerBuffFloorPopupMediator;
   import game.mediator.gui.popup.tower.TowerBuffValueObject;
   import game.view.popup.ClipBasedPopup;
   
   public class TowerBuffFloorPopup extends ClipBasedPopup
   {
       
      
      private const clip:TowerBuffFloorPopupClip = AssetStorage.rsx.popup_theme.create_dialog_tower_buff_floor();
      
      private var mediator:TowerBuffFloorPopupMediator;
      
      public function TowerBuffFloorPopup(param1:TowerBuffFloorPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         var _loc2_:int = 0;
         super.initialize();
         addChild(clip.graphics);
         clip.button_close.signal_click.add(mediator.close);
         clip.title = Translate.translate("UI_TOWER_BUFF_POPUP_TITLE");
         clip.tf_caption.text = Translate.translate("UI_TOWER_BUFF_POPUP_CAPTION");
         var _loc3_:Vector.<TowerBuffValueObject> = mediator.buffs;
         var _loc1_:int = _loc3_.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            clip.buff[_loc2_].setData(_loc3_[_loc2_]);
            clip.buff[_loc2_].animate(_loc2_);
            _loc2_++;
         }
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
      }
   }
}
