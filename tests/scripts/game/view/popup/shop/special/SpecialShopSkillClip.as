package game.view.popup.shop.special
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.mediator.gui.popup.billing.bundle.BundleSkillValueObject;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.tooltip.TooltipTextView;
   import game.view.popup.hero.upgrade.SkillIconClip;
   
   public class SpecialShopSkillClip extends GuiClipNestedContainer
   {
       
      
      public var tf_skill_label:ClipLabel;
      
      public var tf_skill_name:ClipLabel;
      
      public var skillIcon:SkillIconClip;
      
      public var bg:GuiClipScale9Image;
      
      private var _data:BundleSkillValueObject;
      
      public function SpecialShopSkillClip()
      {
         tf_skill_label = new ClipLabel();
         tf_skill_name = new ClipLabel();
         skillIcon = new SkillIconClip();
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         super();
      }
      
      public function get data() : BundleSkillValueObject
      {
         return _data;
      }
      
      public function set data(param1:BundleSkillValueObject) : void
      {
         if(_data == param1)
         {
            return;
         }
         if(_data != null)
         {
            TooltipHelper.removeTooltip(graphics);
         }
         _data = param1;
         skillIcon.data = param1.skill;
         var _loc2_:TooltipVO = new TooltipVO(TooltipTextView,param1.name + "\n" + param1.desc);
         TooltipHelper.addTooltip(graphics,_loc2_);
      }
   }
}
