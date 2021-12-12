import { reactive, readonly } from "vue";

// eslint-disable-next-line
export abstract class Store<T extends object> {
  protected state: T;

  constructor() {
    const data = this.data();
    this.setup(data);
    this.state = reactive(data) as T;
  }

  protected abstract data(): T;

  // eslint-disable-next-line  @typescript-eslint/no-unused-vars, @typescript-eslint/no-empty-function
  protected setup(data: T): void {}

  public getState(): T {
    return readonly(this.state) as T;
  }
}
