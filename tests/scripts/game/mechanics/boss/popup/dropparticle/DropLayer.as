package game.mechanics.boss.popup.dropparticle
{
   import starling.animation.IAnimatable;
   import starling.core.Starling;
   import starling.display.DisplayObjectContainer;
   import starling.display.Sprite;
   import starling.events.Event;
   
   public class DropLayer implements IAnimatable
   {
       
      
      private var activeWhenHidden:Boolean;
      
      public const graphics:DisplayObjectContainer = new Sprite();
      
      public const system:DropParticleSystem = new DropParticleSystem();
      
      public function DropLayer(param1:Boolean = false)
      {
         super();
         if(param1)
         {
            Starling.juggler.add(this);
         }
         else
         {
            graphics.addEventListener("enterFrame",onEnterFrame);
         }
      }
      
      public function dispose() : void
      {
         if(activeWhenHidden)
         {
            Starling.juggler.remove(this);
         }
         else
         {
            graphics.removeEventListener("enterFrame",onEnterFrame);
         }
      }
      
      public function advanceTime(param1:Number) : void
      {
         system.advanceTime(param1);
      }
      
      public function add(param1:InventoryItemDropParticle, param2:Vector.<DropParticleMovement>) : void
      {
         system.addParticle(param1,param2);
         graphics.addChild(param1.graphics);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         advanceTime(Number(param1.data));
      }
   }
}
