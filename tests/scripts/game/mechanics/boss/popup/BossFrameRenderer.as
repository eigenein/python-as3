package game.mechanics.boss.popup
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipImage;
   import game.mechanics.boss.storage.BossTypeDescription;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.tooltip.TooltipTextView;
   import starling.display.Image;
   
   public class BossFrameRenderer extends ClipButton
   {
       
      
      public var tf_name:ClipLabel;
      
      public var coin_image:GuiClipImage;
      
      public var container_boss_icon:ClipLayout;
      
      public var roundSelector_inst0:ClipSprite;
      
      public var event_renderer_title_bg_inst0:ClipSprite;
      
      public var mediator:BossFrameRendererMediator;
      
      public function BossFrameRenderer()
      {
         tf_name = new ClipLabel();
         coin_image = new GuiClipImage();
         container_boss_icon = ClipLayout.none();
         roundSelector_inst0 = new ClipSprite();
         event_renderer_title_bg_inst0 = new ClipSprite();
         super();
      }
      
      public function dispose() : void
      {
         TooltipHelper.removeTooltip(coin_image.graphics);
      }
      
      public function setData(param1:BossTypeDescription) : void
      {
         tf_name.text = param1.name;
         coin_image.image.texture = mediator.getBossCoinIcon(param1);
         TooltipHelper.removeTooltip(coin_image.graphics);
         var _loc3_:TooltipVO = new TooltipVO(TooltipTextView,null);
         _loc3_.hintData = Translate.fastTranslate("UI_DIALOG_BOSS_COIN_TOOLTIP",[mediator.getBossCoinName(param1)]);
         TooltipHelper.addTooltip(coin_image.graphics,_loc3_);
         var _loc2_:Image = new Image(mediator.getBossIcon(param1));
         container_boss_icon.removeChildren();
         container_boss_icon.addChild(_loc2_);
      }
   }
}
