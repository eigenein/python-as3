package game.view.gui.tutorial
{
   import game.view.gui.tutorial.tutorialtarget.ITutorialTargetKey;
   
   public class TutorialNode implements ITutorialTargetKey
   {
      
      private static var idCounter:int = 0;
       
      
      public var id:int;
      
      var name:String;
      
      var children:Vector.<TutorialNode>;
      
      public function TutorialNode(param1:String)
      {
         super();
         idCounter = Number(idCounter) + 1;
         this.id = Number(idCounter);
         this.name = param1;
         children = new Vector.<TutorialNode>();
      }
      
      public static function get maxId() : int
      {
         return idCounter;
      }
   }
}
