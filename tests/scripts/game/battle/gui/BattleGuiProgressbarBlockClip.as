package game.battle.gui
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   
   public class BattleGuiProgressbarBlockClip extends GuiClipNestedContainer
   {
       
      
      private const minWidth:int = 7;
      
      private var healthMaxWidth:int;
      
      private var energyMaxWidth:int;
      
      private var _hp:Number = -1;
      
      private var _energy:Number = -1;
      
      public var progress_bar_health:GuiClipScale3Image;
      
      public var progress_bar_energy:GuiClipScale3Image;
      
      public var progress_bar_energy_max:GuiClipScale3Image;
      
      public function BattleGuiProgressbarBlockClip()
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
            progress_bar_health.graphics.visible = false;
         }
         else
         {
            progress_bar_health.graphics.visible = true;
            progress_bar_health.graphics.width = Math.max(7,int(healthMaxWidth * param1));
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
            progress_bar_energy.graphics.visible = false;
            progress_bar_energy_max.graphics.visible = false;
         }
         else if(param1 >= 1)
         {
            progress_bar_energy.graphics.visible = false;
            progress_bar_energy_max.graphics.visible = true;
         }
         else
         {
            progress_bar_energy.graphics.visible = true;
            progress_bar_energy_max.graphics.visible = false;
            progress_bar_energy.graphics.width = Math.max(7,int(energyMaxWidth * param1));
         }
      }
      
      public function set disabled(param1:Boolean) : void
      {
         graphics.alpha = !!param1?0.4:1;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         healthMaxWidth = int(progress_bar_health.graphics.width);
         energyMaxWidth = int(progress_bar_energy.graphics.width);
      }
   }
}
