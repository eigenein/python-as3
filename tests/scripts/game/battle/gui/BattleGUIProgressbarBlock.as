package game.battle.gui
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   
   public class BattleGUIProgressbarBlock extends GuiClipNestedContainer
   {
       
      
      private var _hp:Number = -1;
      
      private var _energy:Number = -1;
      
      public var progbarFILLGreen_3_3_2_inst0:GuiClipScale3Image;
      
      public var progbarFILLGold_3_3_2_inst0:GuiClipScale3Image;
      
      public var progbarFILLYellow_3_3_2_inst0:GuiClipScale3Image;
      
      public var progbarBG_3_3_2_inst0:GuiClipScale3Image;
      
      public var progbarBG_3_3_2_inst1:GuiClipScale3Image;
      
      public var progbarsBG_18_18_2_inst0:GuiClipScale3Image;
      
      private var maxWidth:int;
      
      private var minWidth:int;
      
      public function BattleGUIProgressbarBlock()
      {
         super();
      }
      
      public function set hp(param1:Number) : void
      {
         if(param1 > 1)
         {
            param1 = 1;
         }
         else if(param1 < 0)
         {
            param1 = 0;
         }
         if(_hp == param1)
         {
            return;
         }
         _hp = param1;
         if(param1 <= 0)
         {
            progbarFILLGreen_3_3_2_inst0.graphics.visible = false;
         }
         else
         {
            progbarFILLGreen_3_3_2_inst0.graphics.visible = true;
            progbarFILLGreen_3_3_2_inst0.graphics.width = Math.max(minWidth,int(maxWidth * param1));
         }
      }
      
      public function set energy(param1:Number) : void
      {
         if(_energy == param1)
         {
            return;
         }
         _energy = param1;
         if(param1 <= 0)
         {
            progbarFILLYellow_3_3_2_inst0.graphics.visible = false;
            progbarFILLGold_3_3_2_inst0.graphics.visible = false;
         }
         else if(param1 >= 1)
         {
            progbarFILLYellow_3_3_2_inst0.graphics.visible = false;
            progbarFILLGold_3_3_2_inst0.graphics.visible = true;
         }
         else
         {
            progbarFILLYellow_3_3_2_inst0.graphics.visible = true;
            progbarFILLGold_3_3_2_inst0.graphics.visible = false;
            progbarFILLYellow_3_3_2_inst0.graphics.width = Math.max(minWidth,int(maxWidth * param1));
         }
      }
      
      public function set disabled(param1:Boolean) : void
      {
         graphics.alpha = !!param1?0.4:1;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         maxWidth = int(progbarFILLGreen_3_3_2_inst0.graphics.width);
         minWidth = 7;
      }
   }
}
