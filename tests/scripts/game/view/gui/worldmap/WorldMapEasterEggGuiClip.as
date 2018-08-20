package game.view.gui.worldmap
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.mediator.gui.worldmap.WorldMapEasterEggMediator;
   import game.view.gui.components.ClipButton;
   
   public class WorldMapEasterEggGuiClip extends GuiClipNestedContainer
   {
      
      public static const MAP_ID:int = 9;
       
      
      private var mediator:WorldMapEasterEggMediator;
      
      private var _index:int;
      
      private var _mark:Boolean;
      
      public var stone:Vector.<ClipButtonMapSecret>;
      
      public var final_mark:ClipButtonMapSecretAnimation;
      
      public var lighthouse:ClipButton;
      
      public function WorldMapEasterEggGuiClip(param1:WorldMapEasterEggMediator)
      {
         stone = new Vector.<ClipButtonMapSecret>();
         final_mark = new ClipButtonMapSecretAnimation();
         lighthouse = new ClipButton();
         super();
         this.mediator = param1;
         param1.signal_update.add(handler_update);
      }
      
      public function update() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = 0;
         _loc2_ = 0;
         if(mediator.isAvailable_pirateTreasure)
         {
            lighthouse.graphics.visible = false;
            lighthouse.signal_click.add(handler_lightHouse_click);
            final_mark.graphics.visible = false;
            final_mark.signal_click.add(handler_mark_click);
            _loc1_ = stone.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               stone[_loc2_].index = _loc2_ + 1;
               stone[_loc2_].signal_click.add(handler_clickStone);
               _loc2_++;
            }
         }
         else
         {
            lighthouse.graphics.touchable = false;
            final_mark.graphics.visible = false;
            _loc1_ = stone.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               stone[_loc2_].graphics.visible = false;
               _loc2_++;
            }
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         update();
      }
      
      private function handler_clickStone(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = 0;
         _loc3_ = 0;
         var _loc4_:Boolean = false;
         if(!_index)
         {
            _index = param1;
            _loc4_ = true;
         }
         else if(param1 == _index + 1 || _index == stone.length && param1 == 1)
         {
            _index = param1;
            _loc4_ = true;
         }
         if(_loc4_)
         {
            stone[param1 - 1].graphics.visible = false;
         }
         else
         {
            _loc2_ = stone.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               stone[_loc3_].graphics.visible = true;
               _loc3_++;
            }
         }
         _mark = true;
         _loc2_ = stone.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _mark = _mark && !stone[_loc3_].graphics.visible;
            _loc3_++;
         }
         if(_mark)
         {
            lighthouse.graphics.visible = true;
         }
      }
      
      private function handler_lightHouse_click() : void
      {
         final_mark.anim.playOnce();
         final_mark.graphics.visible = true;
      }
      
      private function handler_mark_click() : void
      {
         mediator.action_farmTreasure();
      }
      
      private function handler_update() : void
      {
         update();
      }
   }
}
