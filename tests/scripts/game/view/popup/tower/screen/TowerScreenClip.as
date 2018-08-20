package game.view.popup.tower.screen
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   import game.mediator.gui.popup.tower.TowerScreenBuffValueObject;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.tooltip.TooltipTextView;
   import game.view.popup.tower.TowerBuffIcon;
   import game.view.popup.tower.complete.TowerCompletePanel;
   
   public class TowerScreenClip extends GuiClipNestedContainer
   {
       
      
      public var button_close:ClipButtonLabeled;
      
      public var button_rules:ClipButtonLabeled;
      
      public var button_shop:ClipButtonLabeled;
      
      public var tf_label_points:ClipLabel;
      
      public var tf_points:ClipLabel;
      
      public var tf_label_buffs:ClipLabel;
      
      public var complete_panel:TowerCompletePanel;
      
      public var bg_buffs:GuiClipScale3Image;
      
      public var points_bg:GuiClipScale3Image;
      
      public var buff_1:TowerBuffIcon;
      
      public var buff_2:TowerBuffIcon;
      
      public var buff_3:TowerBuffIcon;
      
      public var buff_4:TowerBuffIcon;
      
      public var buff_5:TowerBuffIcon;
      
      public var floor_view:TowerScreenFloorClip;
      
      public var layout_buff_list:ClipLayout;
      
      public var layout_resource_list:ClipLayout;
      
      public function TowerScreenClip()
      {
         button_close = new ClipButtonLabeled();
         button_rules = new ClipButtonLabeled();
         button_shop = new ClipButtonLabeled();
         tf_label_points = new ClipLabel();
         tf_points = new ClipLabel();
         tf_label_buffs = new ClipLabel();
         complete_panel = new TowerCompletePanel();
         bg_buffs = new GuiClipScale3Image(6,1,"vertical");
         points_bg = new GuiClipScale3Image(19,1);
         buff_1 = new TowerBuffIcon();
         buff_2 = new TowerBuffIcon();
         buff_3 = new TowerBuffIcon();
         buff_4 = new TowerBuffIcon();
         buff_5 = new TowerBuffIcon();
         floor_view = new TowerScreenFloorClip();
         layout_buff_list = ClipLayout.horizontalMiddleCentered(4,buff_1,buff_2,buff_3,buff_4,buff_5);
         layout_resource_list = ClipLayout.horizontalMiddleCentered(4,floor_view);
         super();
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:int = 5;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = this["buff_" + (_loc3_ + 1)];
            TooltipHelper.removeTooltip(_loc1_.graphics);
            _loc3_++;
         }
         complete_panel.dispose();
      }
      
      public function setBuffList(param1:Vector.<TowerScreenBuffValueObject>) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc3_:int = 5;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = this["buff_" + (_loc4_ + 1)];
            TooltipHelper.removeTooltip(_loc2_.graphics);
            if(param1.length > _loc4_)
            {
               _loc2_.graphics.visible = true;
               _loc2_.data = param1[_loc4_].icon;
               _loc2_.tf_value.text = param1[_loc4_].value;
               _loc5_ = new TooltipVO(TooltipTextView,param1[_loc4_].desc);
               TooltipHelper.addTooltip(_loc2_.graphics,_loc5_);
            }
            else
            {
               _loc2_.graphics.visible = false;
            }
            _loc4_++;
         }
      }
   }
}
