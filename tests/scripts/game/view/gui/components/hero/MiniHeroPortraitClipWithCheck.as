package game.view.gui.components.hero
{
   import engine.core.clipgui.ClipSprite;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.tooltip.InventoryItemInfoTooltip;
   
   public class MiniHeroPortraitClipWithCheck extends MiniHeroPortraitClip
   {
       
      
      private var _tooltipVO:TooltipVO;
      
      public var check:ClipSprite;
      
      public function MiniHeroPortraitClipWithCheck()
      {
         _tooltipVO = new TooltipVO(InventoryItemInfoTooltip,null);
         check = new ClipSprite();
         super();
      }
      
      public function dispose() : void
      {
         TooltipHelper.removeTooltip(graphics);
      }
      
      public function set checked(param1:Boolean) : void
      {
         check.graphics.visible = param1;
      }
      
      override public function set data(param1:UnitEntryValueObject) : void
      {
         .super.data = param1;
         _tooltipVO.hintData = new InventoryItem(param1.unit);
         TooltipHelper.addTooltip(graphics,_tooltipVO);
      }
   }
}
