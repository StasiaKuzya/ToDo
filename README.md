# Описание проекта ToDo:

Простое приложение для ведения списка дел (ToDo List) с возможностью добавления, редактирования, удаления задач.

# Функциональные требования:

## 1. Список задач:
   - Отображение списка задач на главном экране.
   - Задача должна содержать название, описание, дату создания и статус (выполнена/не выполнена).
   - Возможность добавления новой задачи.
   - Возможность редактирования существующей задачи. //TODO
   - Возможность удаления задачи.

## 2. Загрузка списка задач из сети 
   - Адрес: dummyjson api: https://dummyjson.com/todos. При первом запуске приложение должно загрузить список задач из указанного json api.  
  
## 3. Многопоточность:
   - Обработка создания, загрузки, редактирования и удаления задач должна выполняться в фоновом потоке с использованием GCD или NSOperation.
   - Интерфейс не должен блокироваться при выполнении операций.

## 4. CoreData:
   - Данные о задачах должны сохраняться в CoreData.
   - Приложение должно корректно восстанавливать данные при повторном запуске.
