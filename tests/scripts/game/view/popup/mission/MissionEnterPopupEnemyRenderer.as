package game.view.popup.mission
{
   import game.mediator.gui.popup.hero.HeroEntryValueObject;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.model.user.hero.HeroEntry;
   import game.view.gui.components.HeroPortrait;
   import game.view.gui.components.list.ListItemRenderer;
   import game.view.gui.components.tooltip.TooltipTextView;
   
   public class MissionEnterPopupEnemyRenderer extends ListItemRenderer
   {
       
      
      private var image:HeroPortrait;
      
      private var tooltipVO:TooltipVO;
      
      public function MissionEnterPopupEnemyRenderer()
      {
         tooltipVO = new TooltipVO(TooltipTextView,"");
         super();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         TooltipHelper.removeTooltip(this);
      }
      
      override protected function commitData() : void
      {
         var _loc1_:HeroEntryValueObject = data as HeroEntryValueObject;
         if(_loc1_)
         {
            image.data = _loc1_;
            tooltipVO.hintData = _loc1_.descText;
         }
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:HeroEntry = data as HeroEntry;
         if(!_loc2_)
         {
         }
         .super.data = param1;
         _loc2_ = data as HeroEntry;
         if(!_loc2_)
         {
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         image = new HeroPortrait();
         addChild(image);
         TooltipHelper.addTooltip(this,tooltipVO);
      }
   }
}
