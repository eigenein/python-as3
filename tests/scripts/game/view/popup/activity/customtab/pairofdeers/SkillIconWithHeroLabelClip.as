package game.view.popup.activity.customtab.pairofdeers
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.mediator.gui.popup.billing.bundle.BundleSkillValueObject;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.tooltip.TooltipTextView;
   import game.view.popup.hero.upgrade.SkillIconClip;
   
   public class SkillIconWithHeroLabelClip extends GuiClipNestedContainer
   {
       
      
      public var tf_name:ClipLabel;
      
      public var tf_hero:ClipLabel;
      
      public var icon:SkillIconClip;
      
      private var _data:BundleSkillValueObject;
      
      public function SkillIconWithHeroLabelClip()
      {
         tf_name = new ClipLabel();
         tf_hero = new ClipLabel();
         icon = new SkillIconClip();
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
         _data = param1;
         tf_name.text = param1.name;
         icon.data = param1.skill;
         var _loc2_:TooltipVO = new TooltipVO(TooltipTextView,param1.name + "\n" + param1.desc);
         TooltipHelper.addTooltip(graphics,_loc2_);
      }
   }
}
